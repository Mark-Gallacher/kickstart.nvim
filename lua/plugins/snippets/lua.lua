local ls = require 'luasnip'
local s = ls.snippet
-- local t = ls.text_node
local i = ls.insert_node
-- local extras = require 'luasnip.extras'
-- local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt

return {
    -- basic code snippet form
    ---@module "luasnip"
    s(
        {
            trig = 'snpt', snippetType = "autosnippet"
        },
        fmt(
            [=[
  s("{}", fmt([[
  {}
  ]],
    {{ {} }}
    )
  ),
  ]=],
            {
                i(1, 'trig'),
                i(2, 'string'),
                i(3, 'nodes'),
            }
        )
    ),

    -- autosnippet code
    s(
        { trig = 'snpa', snippetType = "autosnippet" },
        fmt(
            [=[
    s(
      {{ trig = "{}", snippetType = "autosnippet" }},
      fmt([[
    {}
    ]],
      {{ {} }}
      )
    ),
    ]=],
            {
                i(1, 'trig'),
                i(2, 'string'),
                i(3, 'nodes'),
            }
        )
    ),

    -- multiline comment
    s(
        { trig = 'mll', snippetType = "autosnippet" },
        fmt(
            [=[
  --[[
  {}
  --]]
  ]=],
            { i(1) }
        )
    ),
}
