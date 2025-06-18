local ls = require 'luasnip'
local s = ls.snippet
-- local t = ls.text_node
local i = ls.insert_node
-- local c = ls.choice_node
-- local extras = require 'luasnip.extras'
-- local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta

return {

  s(
    'tmpi',
    fmt(
      [[
    ---
    id: {}
    aliases:
        {}
    tags:
        {}
    ---
    ---
    # {}
    {}
    ]],
      { i(0, 'filename'), i(1, 'aliases'), i(2, 'tags'), i(3, 'title'), i(4) }
    )
  ),

  -- obsidian link
  s({ trig = 'llf', snippetType = 'autosnippet' }, fmt('[[{}|{}]]', { i(1, 'filename'), i(2, 'alias') })),
}
