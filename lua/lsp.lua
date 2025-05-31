-- Based on https://github.com/NTBBloodbath/nvim/blob/main/lua/core/lsp.lua
-- Based on https://github.com/Rishabh672003/Neovim/blob/main/lua/rj/lsp.lua

-- Icons to Improve the LSP UI
local icons = {
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = "󰊕 ",
    Interface = " ",
    Keyword = " ",
    Method = "ƒ ",
    Module = "󰏗 ",
    Property = " ",
    Snippet = " ",
    Struct = " ",
    Text = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
}

local completion_kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(completion_kinds) do
    completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
end


-- LSP Capabilities
-- Begin with getting the default ones, then we can modify them
local capabilities = vim.lsp.protocol.make_client_capabilities()


capabilities.textDocument.foldingRange = {
    dynamicRegistration = true,
    lineFoldingOnly = true,
}

capabilities.textDocument.semanticTokens.multilineTokenSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

local loaded_blink, blink = xpcall(require, debug.traceback, "blink.cmp")
if loaded_blink then
    ---@diagnostic disable-next-line undefined-field
    capabilities = blink.get_lsp_capabilities(capabilities)
end


-- Pass the capabilities to config function
vim.lsp.config("*", {
    capabilities = capabilities,
})


-- User Commands
vim.api.nvim_create_user_command("LspLog", function()
    vim.cmd.vsplit(vim.lsp.log.get_filename())
end, {
    desc = "Get all the lsp logs",
})

vim.api.nvim_create_user_command("LspInfo", function()
    vim.cmd("silent checkhealth vim.lsp")
end, {
    desc = "Get all the information about all LSP attached",
})
