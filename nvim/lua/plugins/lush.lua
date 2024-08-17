return {
    "rktjmp/lush.nvim",
    priority = 1000,
    { dir = "{{command_output "echo -n $HOME"}}/.config/nvim", lazy = true },
}
