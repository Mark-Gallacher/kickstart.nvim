return {
  'danymat/neogen',
  config = function()
    local ng = require 'neogen'

    ng.setup {
      snippet_engine = false,
      languages = {
        ['lua.emmylua'] = require 'neogen.configurations.cpp',
        ['python.numpydoc'] = require 'neogen.configurations.python',
      },
    }
  end,
  -- Uncomment next line if you want to follow only stable versions
  version = '*',
}
