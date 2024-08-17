return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "java",
                "lua",
                "markdown",
                "markdown_inline",
                "rust",
                "toml",
                "vimdoc",
            },
            sync_install = false,
            auto_install = true,
            indent = {
                enable = true
            },
            highlight = {
                enable = true,
            },
        })
        --vim.treesitter.language.register("markdown", "vimwiki")
    end
}
