-- exit insert mode and update the file
vim.keymap.set('i', 'jk', '<esc><cmd>update<cr>')

-- buffer
vim.keymap.set('n', '<C-J>', '<C-W>j')
vim.keymap.set('n', '<C-K>', '<C-W>k')
vim.keymap.set('n', '<C-H>', '<C-W>h')
vim.keymap.set('n', '<C-L>', '<C-W>l')
vim.keymap.set('n', '<Leader>x', '<cmd>q<cr>')
vim.keymap.set('n', '<Leader>l', function() print(vim.fn.expand('%:p')) end)

-- toggle cursorline
vim.keymap.set('n', '<Leader>cl', function() vim.opt.cursorline = not vim.o.cursorline end)

-- search
vim.keymap.set('n', '<Esc>', function() vim.cmd('nohlsearch') end)
vim.keymap.set('n', '<Leader>h', function()
  local word = vim.fn.expand("<cword>")
  vim.fn['functions#SearchWithHighlight']('\\<'..word..'\\>')
  vim.cmd('set hlsearch')
end)

-- percentage based horizontal split/resizing of windows
local function vert_split_percent(percent)
  local exclude_count = 0
  for _, w in ipairs(vim.fn.getwininfo()) do
    if w.quickfix == 1 or w.loclist == 1 or vim.bo[w.bufnr].filetype == "fugitive" then
      exclude_count = exclude_count + 1
    end
  end

  local win_count = vim.fn.winnr('$') - exclude_count
  local width = math.floor(vim.o.columns * percent)

  if win_count > 1 then
    vim.api.nvim_win_set_width(0, width)
  else
    vim.cmd('vertical ' .. width .. 'split')
  end
end
vim.keymap.set('n', '<Leader>v', function() vert_split_percent(0.41) end)

-- windows and tabs
vim.keymap.set('n', '<Leader>gx', function()
    local tab_count = table.getn(vim.fn['gettabinfo']())
    local current_tab_number = vim.fn['tabpagenr']()
    vim.cmd('tabclose')

    -- Closing the last tab means the "left" tab comes into focus. Closing a
    -- tab in the middle shifts focus to the "right". Make the behavior
    -- consistent by always bringing the "left" tab into focus after closing.
    if current_tab_number ~= tab_count then
        vim.cmd('normal gT')
    end
end)
vim.keymap.set('n', '<Leader>z', function() vim.cmd('tab split'); vim.cmd('diffoff') end)

-- completion
vim.keymap.set('i', '<C-j>', function()
    return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-x><C-n>"
end, { expr = true })
vim.keymap.set('i', '<C-k>', function()
    return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-x><C-p>"
end, { expr = true })

-- quickfix
vim.keymap.set('n', '<Leader>e', '<cmd>cn<cr>zz', { silent = true })
vim.keymap.set('n', '<Leader>E', '<cmd>cN<cr>zz', { silent = true })

-- diff
vim.keymap.set('n', '<Leader>co', function()
    -- figure out if this is a new file
    local is_new = vim.fn.getline('.'):find('(new)')
    vim.cmd('tab split')
    vim.cmd('normal 0f]wgf')

    if is_new then
        return
    end

    vim.cmd('Gvdiffsplit ' .. os.getenv('GIT_DIFF_OBJECT'))
    vim.cmd('normal zR]czz')
    vert_split_percent(0.41)
    vim.cmd('windo set foldcolumn=0')
end)

-- yanks
vim.keymap.set('n', '<Leader>y', function()
    vim.cmd('normal "+yiw')
    vim.cmd('echo "Yanked: " . @+')
end)
vim.keymap.set('n', '<Leader>Y', function()
    vim.cmd('normal "+y$')
    vim.cmd('echo "Yanked: " . @+')
end)

-- insert formatted links
local link_insertion_config = {
    parsers = {
        function(input)
            local _, _, title, url = string.find(input, "%[(.+)%]%((.+)%)")
            return title, url
        end,
    },
    transforms = {},
}

-- Load local extensions if they exist
local ok, local_extensions = pcall(require, "local_extensions")
if ok then local_extensions.extend_link_config(link_insertion_config) end

function insert_link()
    local input = vim.fn.getreg("+")
    local title, url

    for _, parse in ipairs(link_insertion_config.parsers) do
        title, url = parse(input)
        if title then break end
    end

    if not title or not url then return end

    title = title:gsub("%[", "("):gsub("%]", ")")

    for _, t in ipairs(link_insertion_config.transforms) do
        if url:find(t.match) then
            title = t.fn(title, url)
            break
        end
    end

    local tw = vim.opt.textwidth:get()
    vim.opt.textwidth = 0
    vim.api.nvim_put({"[" .. title .. "](" .. url .. ")"}, "c", true, true)
    vim.opt.textwidth = tw
end
vim.keymap.set('i', '<C-u>', function()
    insert_link()
end)

-- abbreviation to insert date
vim.keymap.set('ia', 'yr', vim.fn['strftime']("%Y"))
vim.keymap.set('ia', 'ym', vim.fn['strftime']("%Y-%m"))
vim.keymap.set('ia', 'dt', vim.fn['strftime']("%Y-%m-%d"))

-- custom text object selection for markdown code fences
function select_code_fence()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Find opening fence (search backwards)
  local start_line = nil
  for i = row, 1, -1 do
    if lines[i]:match("^```") then
      start_line = i
      break
    end
  end

  -- Find closing fence (search forwards)
  local end_line = nil
  for i = row, #lines do
    if lines[i]:match("^```") and i ~= start_line then
      end_line = i
      break
    end
  end

  if start_line and end_line then
    vim.cmd("normal! \27")
    vim.api.nvim_win_set_cursor(0, {start_line + 1, 0})
    vim.cmd("normal! 0v")
    vim.api.nvim_win_set_cursor(0, {end_line - 1, 0})
    vim.cmd("normal! g_")
  end
end
vim.keymap.set({'x', 'o'}, 'if', select_code_fence, { desc = "Inner code fence" })
