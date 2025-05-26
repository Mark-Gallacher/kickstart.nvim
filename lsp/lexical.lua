-- Elixir
local get_lexical_cmd = function()
    local has_unix = vim.fn.has("unix")
    if has_unix == 0 then
        return nil
    end

    local root_path = vim.fn.stdpath("config")
    root_path = root_path:gsub("%nvim", "")

    return {
        root_path .. 'lexical/_build/dev/package/lexical/bin/start_lexical.sh'
    }
end


---@type vim.lsp.Config
return {

    cmd = get_lexical_cmd(),
    filetypes = { 'elixir', 'eelixir', 'heex', 'surface' },
    root_markers = { 'mix.exs', '.git' },
    settings = {}

}
