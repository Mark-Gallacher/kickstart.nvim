--[[

Overview of Snippets for Python:

    Basics
    - ppr => print
    - ppf => print("f{}")
    - mll => multi-line commentpython
    - mm  => magic method i.e __init__(self):
    - mf  => magic function - no self.
    - nem => if name == main:
    - ipp => import
    - iia => import with alias
    - ffi => from x import x

    Conditionals
    - iif => if statement
    - else => else statement
    - ifel => if else statement
    - ifee => if ifel else statement
    - iis => isinstance

    Loops and Expressions
    - ffr => for loop
    - frr => for loop using range
    - ffn => for loop using enumerate
    - wwi => with statement
    - lmm => lambda statement
    - xx  => except statement
    - xa  => except statement with alias
    - tx  => try except statement
    - xr  => except and raise statements
    - tff => try, except and finally

    Definitions
    - dff => Simple function definition
    - ddf => Function with DocString
    - dtf => Function with Types and DocString
    - dmm => Simple Method definition
    - ddm => Method with DocString
    - dtm => Method with Types and DocString
    - cd  => Simple Class definition
    - ccd => Child Class definition
    - prop => Setter and Getter

    Comprehensions
    - lc  => List comprehension
    - lfc => List comprehension with filter
    - dc  => definition comprehension
    - dfc  => definition comprehension with filter
    - scc => Set comprehension
--]]

local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require 'luasnip.extras'
local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt

return {
    -- print
    s({ trig = 'ppr', snippetType = 'autosnippet' }, fmt('print({})', { i(1, '...') })),

    -- print with f string
    s({ trig = 'ppf', snippetType = 'autosnippet' }, fmt('print(f"{}")', { i(1, '...') })),

    -- multiline string
    -- """ """
    s(
        { trig = 'mll', snippetType = 'autosnippet' },
        fmt(
            [[
"""
{}
"""]],
            { i(1) }
        )
    ),

    -- magic method
    -- __init__(self, ):
    s('mm', { t '__', i(1, 'init'), t '__(self,', i(2), t { '):', '\t' }, i(0) }),

    -- magic function
    -- __init__():
    s('mf', { t '__', i(1, 'init'), t '__(', i(2), t { '):', '\t' }, i(0) }),

    -- if __name__ == "__main__":
    s('nem', { t { 'if __name__ == "__main__":', '\t' }, i(0, 'main()') }),

    -- import
    s({ trig = 'iip', snippetType = 'autosnippet' }, { t 'import ', i(1) }),

    -- import ... as ...
    s({ trig = 'iia', snippetType = 'autosnippet' }, { t 'import ', i(1), t ' as ', i(2) }),

    -- from ... import ...
    s({ trig = 'ffp', snippetType = 'autosnippet' }, { t 'from ', i(1), t ' import ', i(2) }),

    -- if statement
    s({ trig = 'iif', snippetType = 'autosnippet' }, { t 'if ', i(1, 'cond'), t { ':', '\t' }, i(2, '...') }),

    -- else statement
    s({ trig = 'else', snippetType = 'autosnippet' }, { t { 'else:', '\t' }, i(1, '...') }),

    -- if else statement
    s(
        { trig = 'ifel', snippetType = 'autosnippet' },

        fmt(
            [[
  if {}:
      {}

  else:
      {}]],
            {
                i(1, 'cond'),
                i(2, '...'),
                i(3, '...'),
            }
        )
    ),
    -- if, elif, else block statement
    s(
        { trig = 'ifee', snippetType = 'autosnippet' },
        fmt(
            [[
  if {}:
      {}

  elif {}:
      {}

  else:
      {}]],
            {
                i(1, 'cond'),
                i(2, '...'),
                i(3, 'cond'),
                i(4, '...'),
                i(5, '...'),
            }
        )
    ),

    -- for loops
    s(
        { trig = 'ffr', snippetType = 'autosnippet' },
        fmt(
            [[
      for {} in {}:
          {}]],
            { i(1, 'item'), i(2, 'items'), i(3, '...') }
        )
    ),

    s(
        { trig = 'ffn', snippetType = 'autosnippet' },
        fmt(
            [[
      for i, {} in enumerate({}):
          {}]],
            { i(1, 'item'), i(2, 'items'), i(3, '...') }
        )
    ),

    -- for loops with range
    s(
        { trig = 'frr', snippetType = 'autosnippet' },
        fmt(
            [[
  for {} in range({}):
      {}]],
            { i(1, 'item'), i(2, 'items'), i(3, '...') }
        )
    ),
    -- with
    s(
        { trig = 'wwi', snippetType = 'autosnippet' },
        fmt(
            [[
with {} as {}:
    {}]],
            { i(1, 'expression'), i(2, 'alias'), i(3, '...') }
        )
    ),
    -- lambda
    s({ trig = 'lmm', snippetType = 'autosnippet' }, fmt('lambda {}: {}', { i(1, 'arg'), i(2, 'expression') })),

    s(
        { trig = 'dff', snippetType = 'autosnippet' },
        fmt(
            [[
def {}({}):
    {}
    return {}
]],
            {
                i(1, 'name'),
                i(2, 'args'),
                i(3, '...'),
                i(4, 'None'),
            }
        )
    ),

    -- function definition
    s(
        { trig = 'ddf', snippetType = 'autosnippet' },
        fmt(
            [[
  def {}({}):
      """{}"""
      {}
  ]],
            {
                i(1, 'name'),
                i(2, 'args'),
                i(3, 'DocString'),
                i(4, '...'),
            }
        )
    ),

    -- function definition with types
    s(
        { trig = 'dtf', snippetType = 'autosnippet' },
        fmt(
            [[
  def {1}({2}: {3}) -> {4}:
      """{5}
      Param: {7} ({8})
      Returns {9}
      """
      {6}
  ]],
            {
                i(1, 'name'),
                i(2, 'args'),
                i(3, 'None'),
                i(4, 'None'),
                i(5, 'DocString'),
                i(6, '...'),
                rep(2),
                rep(3),
                rep(4),
            }
        )
    ),
    -- Method definition
    s(
        { trig = 'dmm', snippetType = 'autosnippet' },
        fmt(
            [[
  def {}(self, {}):
      {}
  ]],
            {
                i(1, 'name'),
                i(2, 'args'),
                i(3, '...'),
            }
        )
    ),

    s(
        { trig = 'ddm', snippetType = 'autosnippet' },
        fmt(
            [[
  def {}(self, {}):
      """{}"""
      {}
  ]],
            {
                i(1, 'name'),
                i(2, 'args'),
                i(3, 'DocString'),
                i(4, '...'),
            }
        )
    ),

    -- Method definition with types
    s(
        { trig = 'dtm', snippetType = 'autosnippet' },
        fmt(
            [[
  def {1}(self, {2}: {3}) -> {4}:
      """{5}
      Param: {7} ({8})
      Returns {9}
      """
      {6}
  ]],
            {
                i(1, 'name'),
                i(2, 'args'),
                i(3, 'None'),
                i(4, 'None'),
                i(5, 'DocString'),
                i(6, '...'),
                rep(2),
                rep(3),
                rep(4),
            }
        )
    ),

    s(
        {
            trig = 'cd',
            snippetType = 'autosnippet',
        },
        fmt(
            [[
  class {}:
      def __init__(self, {}):
          self.{} = {}
  ]],
            {
                i(1, 'ClassName'),
                i(2, 'arg'),
                rep(2),
                rep(2),
            }
        )
    ),
    -- Class
    s(
        { trig = 'ccd', snippetType = 'autosnippet' },
        fmt(
            [[
  class {}({}):
      """{}"""
      {}
  ]],
            {
                i(1, 'ClassName'),
                i(2, 'ParentClass'),
                i(3, 'DocString'),
                i(4, '...'),
            }
        )
    ),

    -- Property template
    s(
        'prop',
        fmt(
            [[
  @property
  def {}(self):
      """Property: {}"""

      return self._{}

  @{}.setter
  def {}(self, value):
      """Setter for {}"""

      self._{} = value
    ]],
            {
                i(1, 'attribute'),
                rep(1),
                rep(1),
                rep(1),
                rep(1),
                rep(1),
                rep(1),
            }
        )
    ),

    -- Except statement
    s(
        {
            trig = 'xx',
            snippetType = 'autosnippet',
        },
        fmt(
            [[
  except {}:
      {}
  ]],
            { i(1, 'Exception'), i(2, '...') }
        )
    ),

    -- Except statement with alias
    s(
        {
            trig = 'xa',
            snippetType = 'autosnippet',
        },
        fmt(
            [[
  except {} as {}:
      {}
  ]],
            { i(1, 'Exception'), i(2, 'e'), i(3, '...') }
        )
    ),

    -- try except block
    s(
        {
            trig = 'tx',
            snippetType = 'autosnippet',
        },
        fmt(
            [[
  try:
      {}

  except {} as {}:
      {}
  ]],
            { i(1, '...'), i(2, 'Exception'), i(3, 'e'), i(4, '...') }
        )
    ),

    --except and raise
    s(
        {
            trig = 'xr',
            snippetType = 'autosnippet',
        },
        fmt(
            [[
  except {} as {}:

      raise {}
  ]],
            { i(1, 'Exception'), i(2, 'e'), i(3, '...') }
        )
    ),

    -- try except finally
    s(
        {
            trig = 'tff',
            snippetType = 'autosnippet',
        },
        fmt(
            [[
  try:
      {}

  except {} as {}:
      {}

  finally:
      {}
  ]],
            { i(1, '...'), i(2, 'Exception'), i(3, 'e'), i(4, '...'), i(5, '...') }
        )
    ),

    -- list comprehension
    s({
        trig = 'lc',
        snippetType = 'autosnippet',
    }, fmt('[{4}{3} for {1} in {2}]', { i(1, 'item'), i(2, 'items'), rep(1), i(3) })),

    s({
        trig = 'lfc',
        snippetType = 'autosnippet',
    }, fmt('[{4}{3} for {1} in {2} if {5}]', { i(1, 'item'), i(2, 'items'), rep(1), rep(2), i(3, 'cond') })),

    s(
        {
            trig = 'dc',
            snippetType = 'autosnippet',
        },
        fmt('{<4>:<5> for <1>, <2> in <3>}', { i(1, 'key'), i(2, 'value'), i(3, 'iterable'), rep(1), rep(2) }, {
            delimiters = '<>',
        })
    ),

    s(
        {
            trig = 'dfc',
            snippetType = 'autosnippet',
        },
        fmt('{<4>:<5> for <1>, <2> in <3> if <6>}',
            { i(1, 'key'), i(2, 'value'), i(3, 'iterable'), rep(1), rep(2), i(4, 'cond') }, {
                delimiters = '<>',
            })
    ),

    s(
        {
            trig = 'scc',
            snippetType = 'autosnippet',
        },
        fmt('{<4><3> for <1> in <2>}', { i(1, 'item'), i(2, 'items'), rep(1), i(3) }, {
            delimiters = '<>',
        })
    ),
    -- isinstance
    s({
        trig = 'iis',
        snippetType = 'autosnippet',
    }, fmt('isinstance({1}, {2})', { i(1, 'var'), i(2, 'type') })),
}
-- vim: ts=2 sts=2 sw=2 et
