return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            sync_install = false,
            auto_install = true,
            indent = {
                enable = false
            },
            highlight = {
                enable = true,
            },
        })
        --vim.treesitter.language.register("markdown", "vimwiki")
    end
}
