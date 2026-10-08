-- notes.lua - Gives nvim the ability to create and edit files in the knowledge
-- base. This is meant to only be a subset of the functionality in
-- scripts/notes.sh. Keep notes.sh as the source of truth for functionality.

local M = {}

-- Keep the paths aligned with notes.sh
local root = "{{kms_path}}"
local cfg = {
    root      = root,
    inbox     = root .. "/inbox",
    projects  = root .. "/projects",
    domains   = root .. "/domains",
    resources = root .. "/resources",
    templates = root .. "/resources/templates",
}

-- Collections keyed by the singular label used in prompts/commands.
local collections = {
    project  = { dir = cfg.projects,  label = "Project" },
    p        = { dir = cfg.projects,  label = "Project" },
    domain   = { dir = cfg.domains,   label = "Domain" },
    d        = { dir = cfg.domains,   label = "Domain" },
    resource = { dir = cfg.resources, label = "Resource" },
    r        = { dir = cfg.resources, label = "Resource" },
}

------------------------------------------------------------------------
-- Pure helpers (mirror notes.sh)
------------------------------------------------------------------------

local function sanitize_name(name)
    return (name:lower():gsub("[^%w %-]", ""):gsub("%s+", "-"))
end

local function dated(slug)
    return os.date("%Y-%m-%d") .. "__" .. slug .. ".md"
end

local function instantiate_template(src, dest, date)
    date = date or os.date("%Y-%m-%d")
    local f = io.open(src, "r")
    if not f then
        return false
    end
    local body = f:read("*a")
    f:close()
    body = body:gsub("{date}", date)
    local out = io.open(dest, "w")
    if not out then
        return false
    end
    out:write(body)
    out:close()
    return true
end

local function list_collection(base)
    local entries = {}
    for name, kind in vim.fs.dir(base) do
        if kind == "directory" then
            table.insert(entries, name)
        end
    end
    table.sort(entries)
    return entries
end

local function open(path, insert)
    vim.cmd.edit(vim.fn.fnameescape(path))
    if insert then
        vim.cmd.startinsert()
    end
end

-- Prompt for a name, sanitize it, and call `cont(slug)`. Aborts on empty.
local function prompt_slug(label, cont)
    vim.ui.input({ prompt = label .. ": " }, function(input)
        if not input or input == "" then
            return
        end
        local slug = sanitize_name(input)
        if slug == "" then
            vim.notify("Name sanitized to empty", vim.log.levels.WARN)
            return
        end
        cont(slug)
    end)
end

local function is_directory(path)
    local stat = vim.uv.fs_stat(vim.fn.expand(path))
    return stat ~= nil and stat.type == "directory"
end

------------------------------------------------------------------------
-- Telescope pickers
------------------------------------------------------------------------

-- find_files in a directory; Telescope's find_files is already ordered
-- newest-first via the telescope and rg configuration.
local function find_files_in(dir)
    require("telescope.builtin").find_files({ cwd = dir })
end

-- Pick one of `entries` (plus optional prepended `extra` sentinels), calling
-- `on_choice(value)` with the selected string.
local function pick(prompt, entries, extras, on_choice)
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local results = {}
    for _, extra in ipairs(extras) do
        table.insert(results, extra)
    end
    vim.list_extend(results, entries)

    pickers.new({}, {
        prompt_title = prompt,
        finder = finders.new_table({ results = results }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(bufnr)
            actions.select_default:replace(function()
                actions.close(bufnr)
                local sel = action_state.get_selected_entry()
                if sel then
                    on_choice(sel[1])
                end
            end)
            return true
        end,
    }):find()
end

------------------------------------------------------------------------
-- Actions (mirrors notes.sh subcommands)
------------------------------------------------------------------------

function M.new_note()
    prompt_slug("Note name", function(slug)
        vim.fn.mkdir(cfg.inbox, "p")
        open(cfg.inbox .. "/" .. dated(slug), true)
    end)
end

local function create_collection_entry(coll)
    prompt_slug(coll.label .. " name", function(slug)
        local entry = coll.dir .. "/" .. slug
        if vim.fn.isdirectory(entry) == 1 then
            vim.notify(slug .. " already exists", vim.log.levels.WARN)
            return
        end
        vim.fn.mkdir(entry, "p")
        local main = entry .. "/main.md"
        io.open(main, "a"):close()
        open(main, false)
    end)
end

-- Create a new file to an existing collection, with optional template.
local function new_file_in_entry(base)
    prompt_slug("File name", function(slug)
        local filepath = base .. "/" .. slug .. ".md"
        local template_files = {}
        for name, kind in vim.fs.dir(cfg.templates) do
            if kind == "file" then
                table.insert(template_files, name)
            end
        end
        table.sort(template_files)
        pick("Template", template_files, { "Skip template" }, function(choice)
            if choice ~= "Skip template" then
                instantiate_template(cfg.templates .. "/" .. choice, filepath)
            elseif vim.fn.filereadable(filepath) == 0 then
                io.open(filepath, "a"):close()
            end
            open(filepath, false)
        end)
    end)
end

-- make a new directory within a collection or a new file
function M.new_collection(base, label)
    local sentinel = "Create new " .. label:lower()
    local file_sentinel = "Create new file here"
    pick("New in " .. label, list_collection(base), { sentinel, file_sentinel }, function(choice)
        local path = vim.fn.expand(base .. "/" .. choice)
        if choice == sentinel then
            create_collection_entry(coll)
        elseif is_directory(path) then
            M.new_collection(path, label)
        else
            new_file_in_entry(base)
        end
    end)
end

-- list/open notes (inbox)
function M.open_note()
    find_files_in(cfg.inbox)
end

-- open within a collection: pick entry, then find_files in it.
function M.open_collection(kind)
    local coll = collections[kind]
    if not coll then
        vim.notify("Unknown collection: " .. tostring(kind), vim.log.levels.ERROR)
        return
    end
    pick("Open in " .. coll.label, list_collection(coll.dir), { }, function(entry)
        find_files_in(coll.dir .. "/" .. entry)
    end)
end

-- `when` is optional; anything GNU date accepts ("tomorrow", "monday",
-- "2026-09-20", ...) is normalized via `date -d` for parity with the CLI.
function M.timebox(when)
    local date
    if not when or when == "" then
        date = os.date("%Y-%m-%d")
    else
        local out = vim.fn.system({ "date", "-d", when, "+%Y-%m-%d" })
        if vim.v.shell_error ~= 0 then
            vim.notify("Invalid date: " .. when, vim.log.levels.ERROR)
            return
        end
        date = vim.trim(out)
    end

    local filepath = cfg.inbox .. "/" .. date .. "__timebox.md"
    if vim.fn.filereadable(filepath) == 0 then
        vim.fn.mkdir(cfg.inbox, "p")
        instantiate_template(cfg.templates .. "/timebox.md", filepath, date)
    end
    open(filepath, false)
end

------------------------------------------------------------------------
-- Command + keymap registration
------------------------------------------------------------------------

function M.setup()
    -- Usage in ex mode: Nt <sub> [type]
    -- Note that this setup also creates a keymap abbreviation from nt to Nt
    -- Mirrors `nt` verbs (new|list|open [project|domain|resource])
    vim.api.nvim_create_user_command("Nt", function(opts)
        local sub, arg = opts.fargs[1], opts.fargs[2]
        if sub == "new" or sub == "n" then
            if arg then
                local coll = collections[arg]
                if not coll then
                    vim.notify("Unknown collection: " .. tostring(kind), vim.log.levels.ERROR)
                    return
                end

                M.new_collection(coll.dir, coll.label)
            else
                M.new_note()
            end
        elseif sub == "open" or sub == "o" or sub == "list" or sub == "l" then
            if arg then M.open_collection(arg) else M.open_note() end
        elseif sub == "timebox" or sub == "t" then
            M.timebox(arg)
        else
            vim.notify("Usage: Nt {new|open|list} [project|domain|resource] | Nt timebox [date]", vim.log.levels.ERROR)
        end
    end, {
        nargs = "*",
        complete = function(arglead, line)
            -- Untrimmed split so a trailing space advances to the next arg slot.
            local parts = vim.split(line, "%s+")
            local candidates
            if #parts <= 2 then
                candidates = { "new", "open", "list", "timebox" }
            elseif parts[2] == "timebox" then
                candidates = { "tomorrow", "yesterday", "sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday" }
            else
                candidates = { "project", "domain", "resource" }
            end
            -- Prefix-filter like compgen -W ... -- "$cur".
            return vim.tbl_filter(function(c) return vim.startswith(c, arglead) end, candidates)
        end,
    })

    vim.keymap.set('ca', 'nt', 'Nt')
    local map = vim.keymap.set
    map("n", "<leader>nt", function() M.timebox() end, { desc = "Notes: timebox (today)" })
end

return M
