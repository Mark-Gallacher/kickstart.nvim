return {
  {
    'epwalsh/obsidian.nvim',
    -- import the latest verions
    version = '*',
    lazy = true,
    -- not sure this is needed
    ft = 'markdown',

    -- this might be better than the cond option.
    -- event = "BufReadPre " .. vim.fn.expand("~") .. "obsidian/General/*.md"
    -- specify the dependencies.
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MeanderingProgrammer/markdown.nvim',
    },
    -- only load when we open the general obsidian value - ie not when we open a markdown or quarto doc
    -- TODO: Change the paths to work on difference computer - i.e. linux
    --
    -- enabled = function()
    --   -- get the os and initialise the root path
    --   local os = vim.loop.os_uname().sysname
    --   local root = ''
    --
    --   -- if we are running windows or os is not known - assume windows
    --   if os == 'Windows_NT' or os == nil then
    --     root = root .. 'D:/Documents/obsidian/'
    --
    --   -- assume we are using linux - so we know what ~ means
    --   else
    --     -- something like vim.fn.expand "~/obsidian/"
    --     root = root .. ''
    --   end
    --
    --   -- get the current directory
    --   local cwd = vim.fn.getcwd()
    --   local vaults = { 'General', 'General/Ideas', 'General/Reference', 'General/Files' }
    --
    --   -- check if we are inside a folder inside a Vault
    --   for _, vault in ipairs(vaults) do
    --     local full_path = root .. vault
    --     if cwd == full_path then
    --       return true
    --     end
    --   end
    --
    --   -- not inside a vault directory
    --   return false
    -- end,
    opts = {

      -- set up the name and path of the vault(s)
      workspaces = {
        {
          name = 'General',
          path = 'D:/Documents/obsidian/General',
        },
      },

      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },

      -- Optional, if you keep notes in a specific subdirectory of your vault.
      notes_subdir = 'Ideas',
      -- Where to put new notes. Valid options are
      --  * "current_dir" - put new notes in same directory as the current buffer.
      --  * "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = 'notes_subdir',

      templates = {
        folder = 'Templates',
        date_format = '%Y-%m-%d',
        time_format = '%H:%M',
      },
    },
  },
}