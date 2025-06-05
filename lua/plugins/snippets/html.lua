local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local d = ls.dynamic_node
local t = ls.text_node
local i = ls.insert_node
-- local c = ls.choice_node
-- local extras = require 'luasnip.extras'
-- local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt
local postfix = require('luasnip.extras.postfix').postfix

return {

  -- Class
  s(
    { trig = "ccl", snippetType = "autosnippet" },
    fmt([[
    class="{}"
    ]],
      { i(0, "body") }
    )
  ),

  -- Turns component;t => <component />
  postfix({
    trig = ";t",
    snippetType = "autosnippet"
  }, {
    d(1, function(_, parent)
      return sn(1,
        fmt("<." .. parent.snippet.env.POSTFIX_MATCH .. " {} />",
          {
            i(1, "component")
          })
      )
    end),
  }),

  -- Turns component;t => <component />
  -- component;lt => <component {} >
  --                    {}
  --                 </component>
  postfix({
    trig = ";lt",
    snippetType = "autosnippet"
  }, {
    d(1, function(_, parent)
      return sn(1,
        fmt("<." .. parent.snippet.env.POSTFIX_MATCH .. " {} >",
          {
            i(1, "component")
          })
      )
    end),
    t({ "", "\t" }),
    i(2, "body"),
    t({ "", "" }),
    d(3, function(_, parent)
      return sn(1,
        fmt("</." .. parent.snippet.env.POSTFIX_MATCH .. ">",
          {})
      )
    end),
  }),

  -- Anchor Tag
  s(
    { trig = ";an", snippetType = "autosnippet" },
    fmt([[
    <a>
        {}
    </a>
    ]],
      { i(0, "body") }
    )
  ),

  -- Paragraph Tag
  s(
    { trig = ";tp", snippetType = "autosnippet" },
    fmt([[
    <p>
        {}
    </p>
    ]],
      { i(0, "body") }
    )
  ),

  -- Button Tag
  s(
    { trig = ";bt", snippetType = "autosnippet" },
    fmt([[
    <button type="button" class="{}">
        {}
    </button>
    ]],
      { i(0, "class"), i(1, "body") }
    )
  ),

  -- Div Tag
  s(
    { trig = ";dv", snippetType = "autosnippet" },
    fmt([[
    <div>
        {}
    </div>
    ]],
      { i(0, "body") }
    )
  ),

  -- Span Tag
  s(
    { trig = ";sp", snippetType = "autosnippet" },
    fmt([[
    <span>
        {}
    </span>
    ]],
      { i(0, "body") }
    )
  ),

}
-- vim: ts=2 sts=2 sw=2 et
