return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
        user_default_options = {
            tailwind = "both",
            tailwind_opts = {
                update_names = true
            },
            mode = "virtualtext",
            virtualtext_inline = "after",
        },
    },
}
