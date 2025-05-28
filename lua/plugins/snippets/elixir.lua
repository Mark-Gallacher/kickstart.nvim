--[[

Overview of Snippets for Elixir

  Basics
  - ppr => IO.puts()
  - pps => IO.inspect()
  - ppls => IO.inspect() with label
  - mll => Multiline comment
  - dss => DocString
  - dsm => DocString for Module
  - ddb => Do End Block
  - ggb => Guard Block
  - ;m => Map
  - ;st => Struct
  - ;c => Case

  Pipe Snippets
  - ;p => Pipe on new line
  - ;d => Pipe into dbg()
  - ;sp => Pipe into String
  - ;lp => Pipe into List
  - ;mp => Pipe into Map
  - ;ep => Pipe into Enum
  - ;emp => Pipe into Enum.map
  - ;erp => Pipe into Enum.reduce
  - ;efp => Pipe into Enum.filter
  - ;etp => Pipe into Ecto

  Conditionals
  - iif => If statement
  - ifel => If else statement
  - ccd => Cond Structure
  - ccs => Case Structure

  Definitions
  - dmm => Module definition
  - ddm => Module definition with ModuleString
  - aaf => Annoymous Function - single line
  - amf => Annoymous Function - multiple lines
  - dff => Public function definition
  - dfo => Public function definition as one-liner
  - dgff => Public function definition with Guard
  - ddf => Public Function with DocString
  - dpf => Private function definition
  - dpo => Private function definition as one-liner
  - dgpf => Private function definition with Guard
  - ddpf => Private Function with DocString

  Testing
  - tcc => Define Test Block
  - tdd => Define Describe Block
  - taa => Assert statement
  - tae => Assert statement with Equality
  - tme => Assert statement with Pattern


--]]

local ls = require 'luasnip'
local s = ls.snippet
-- local t = ls.text_node
local i = ls.insert_node
-- local c = ls.choice_node
-- local extras = require 'luasnip.extras'
-- local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt

local ok = {
  -- INFO: Basics

  -- Puts
  s(
    { trig = 'ppr', snippetType = 'autosnippet' },
    fmt(
      [[
IO.puts({})
]],
      { i(1) }
    )
  ),

  -- Inspect
  s(
    { trig = 'pps', snippetType = 'autosnippet' },
    fmt(
      [[
IO.inspect({})
]],
      { i(1) }
    )
  ),

  -- Inspect with Label
  s(
    { trig = 'ppls', snippetType = 'autosnippet' },
    fmt(
      [[
IO.inspect({}, label: "{}")
]],
      { i(1), i(2, "label") }
    )
  ),

  -- Multiline string
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

  -- Docstring
  s(
    { trig = 'dss', snippetType = 'autosnippet' },
    fmt(
      [[
@doc ~s"""
{}
"""]],
      { i(1) }
    )
  ),

  -- Module Docstring
  s(
    { trig = 'dsm', snippetType = 'autosnippet' },
    fmt(
      [[
@moduledoc ~s"""
{}
"""]],
      { i(1) }
    )
  ),

  -- Do End block
  s(
    { trig = 'ddb', snippetType = 'autosnippet' },
    fmt(
      [[do
{}
end]],
      { i(1) }
    )
  ),

  -- Guard statement (block)
  s(
    { trig = 'ggb', snippetType = 'autosnippet' },
    fmt(
      [[ when {}({}) ]],
      { i(1, "guard"), i(2, "arg") }
    )
  ),

  -- Map
  s(
    { trig = ';m', snippetType = 'autosnippet' },
    fmt(
      [[%{{ {} }}]],
      { i(1) }
    )
  ),

  -- Struct
  s(
    { trig = ';st', snippetType = 'autosnippet' },
    fmt(
      [[%{}{{ {} }}]],
      { i(1, "Struct"), i(2) }
    )
  ),

  -- Case
  s(
    { trig = ';c', snippetType = 'autosnippet' },
    fmt(
      [[


  {} ->
    {}]],
      { i(1, "case"), i(2, "then...") }
    )
  ),


  --INFO: Pipe Snippets
  --
  -- Pipe Character
  s(
    { trig = ';p', snippetType = 'autosnippet' },
    fmt(
      [[


|> {}
]],
      { i(1) }
    )
  ),

  -- Pipe Character into dbg()
  s(
    { trig = ';d', snippetType = 'autosnippet' },
    fmt(
      [[


|> dbg()
]], {}
    )
  ),

  -- Pipe Character with String
  s(
    { trig = ';sp', snippetType = 'autosnippet' },
    fmt(
      [[


|> String.{}({})
]],
      { i(1, "function"), i(2) }
    )
  ),

  -- Pipe Character with List
  s(
    { trig = ';lp', snippetType = 'autosnippet' },
    fmt(
      [[


|> List.{}({})
]],
      { i(1, "function"), i(2) }
    )
  ),

  -- Pipe Character with Map
  s(
    { trig = ';mp', snippetType = 'autosnippet' },
    fmt(
      [[


|> Map.{}({})
]],
      { i(1, "function"), i(2) }
    )
  ),

  -- Pipe Character with Enum
  s(
    { trig = ';ep', snippetType = 'autosnippet' },
    fmt(
      [[


|> Enum.{}({})
]],
      { i(1, "function"), i(2) }
    )
  ),
  -- Pipe Character with Enum.map
  s(
    { trig = ';emp', snippetType = 'autosnippet' },
    fmt(
      [[


|> Enum.map({})
]],
      { i(1) }
    )
  ),

  -- Pipe Character with Enum.reduce
  s(
    { trig = ';erp', snippetType = 'autosnippet' },
    fmt(
      [[


|> Enum.reduce({}, fn {}, {} ->
{}
end)
]],
      { i(1, "acc"), i(2, "args"), i(3, "acc"), i(4, "body") }
    )
  ),

  -- Pipe Character with Enum.filter
  s(
    { trig = ';efp', snippetType = 'autosnippet' },
    fmt(
      [[


|> Enum.filter({})
]],
      { i(1) }
    )
  ),

  -- Pipe Character with Ecto
  s(
    { trig = ';etp', snippetType = 'autosnippet' },
    fmt(
      [[


|> Ecto.{}({})
]],
      { i(1, "function"), i(2) }
    )
  ),


  -- INFO: Conditionals

  -- if statement
  s(
    { trig = "iif", snippetType = "autosnippet" },
    fmt([[
  if {} do
  {}
  end
  ]],
      { i(1, "condition"), i(2, "then...") }
    )
  ),

  -- if else statement
  s(
    { trig = "ifel", snippetType = "autosnippet" },
    fmt([[
  if {} do
    {}
  else
    {}
  end
  ]],
      { i(1, "condition"), i(2, "then..."), i(3, "then...") }
    )
  ),

  -- cond structure
  s(
    { trig = "ccd", snippetType = "autosnippet" },
    fmt([[
cond do
  {} ->
    {}
  true ->
    {}
  end
  ]],
      { i(1, "condition"), i(2, "then..."), i(3, "finally...") }
    )
  ),

  -- case structure
  s(
    { trig = "ccs", snippetType = "autosnippet" },
    fmt([[
case {} do
  {} ->
    {}
  _ ->
    {}
  end
  ]],
      { i(1, "capture"), i(2, "clause"), i(3, "then..."), i(4, "finally...") }
    )
  ),


  -- INFO: Definitions
  --
  -- Module Definitions
  s(
    { trig = "dmm", snippetType = "autosnippet" },
    fmt([[
  defmodule {} do
    {}
  end
]],
      { i(1, "module"), i(2, "body") }
    )
  ),

  -- Module Definitions with DocString
  s(
    { trig = "ddm", snippetType = "autosnippet" },
    fmt([[
  defmodule {} do
  @moduledoc ~s"""
  {}
  """
    {}
  end
]],
      { i(1, "module"), i(2, "docstring"), i(3, "body") }
    )
  ),

  -- Annoymous Function - single line
  s(
    { trig = "aaf", snippetType = "autosnippet" },
    fmt([[
  fn {} -> {} end
  ]],
      { i(1, "args"), i(2, "body") }
    )
  ),

  -- Annoymous Function - multiple line
  s(
    { trig = "amf", snippetType = "autosnippet" },
    fmt([[
  fn {} ->
  {}
  end
  ]],
      { i(1, "args"), i(2, "body") }
    )
  ),

  -- Public Function Definitions
  s(
    { trig = "dff", snippetType = "autosnippet" },
    fmt([[
  def {}({}) do
    {}
  end
]],
      { i(1, "function"), i(2, "args"), i(3, "body") }
    )
  ),

  -- Public Function Definitions as one-liner
  s(
    { trig = "dfo", snippetType = "autosnippet" },
    fmt([[
  def {}({}), do: {}
]],
      { i(1, "function"), i(2, "args"), i(3, "body") }
    )
  ),

  -- Public Function Definitions with Guard
  s(
    { trig = "dgff", snippetType = "autosnippet" },
    fmt([[
  def {}({}) when {}({}) do
    {}
  end
]],
      { i(1, "function"), i(2, "args"), i(3, "guard"), i(4, "args"), i(5, "body") }
    )
  ),

  -- Public Function Definitions with DocString
  s(
    { trig = "ddf", snippetType = "autosnippet" },
    fmt([[
  @doc ~s"""
  {}
  """
  def {}({}) do
    {}
  end
]],
      { i(1, "DocString"), i(2, "function"), i(3, "args"), i(4, "body") }
    )
  ),

  -- Private Function Definitions
  s(
    { trig = "dpf", snippetType = "autosnippet" },
    fmt([[
  defp {}({}) do
    {}
  end
]],
      { i(1, "function"), i(2, "args"), i(3, "body") }
    )
  ),

  -- Private Function Definitions as one-liner
  s(
    { trig = "dpo", snippetType = "autosnippet" },
    fmt([[
  defp {}({}), do: {}
]],
      { i(1, "function"), i(2, "args"), i(3, "body") }
    )
  ),

  -- Private Function Definitions with Guard
  s(
    { trig = "dgpf", snippetType = "autosnippet" },
    fmt([[
  defp {}({}) when {}({}) do
    {}
  end
]],
      { i(1, "function"), i(2, "args"), i(3, "guard"), i(4, "args"), i(5, "body") }
    )
  ),

  -- Private Function Definitions with DocString
  s(
    { trig = "ddpf", snippetType = "autosnippet" },
    fmt([[
  @doc ~s"""
  {}
  """
  defp {}({}) do
    {}
  end
]],
      { i(1, "DocString"), i(2, "function"), i(3, "args"), i(4, "body") }
    )
  ),


  -- INFO: Testing
  --
  -- Define basic test
  s(
    { trig = "tcc", snippetType = "autosnippet" },
    fmt([[
test "{}" do

  {}

end
  ]],
      { i(1, "test name"), i(2, "...") }
    )
  ),

  -- Define test context
  s(
    { trig = "tdd", snippetType = "autosnippet" },
    fmt([[

describe {} do
  test "{}" do

    {}

  end

  test "{}" do

    {}

  end
end
  ]],
      { i(1, "test context"),
        i(2, "test name"),
        i(3, "..."),
        i(4, "test name"),
        i(5, "...") }
    )
  ),

  -- Assert statement
  s(
    { trig = "taa", snippetType = "autosnippet" },
    fmt([[
  assert {}
  ]],
      { i(1, "condition") }
    )
  ),

  -- Assert is Equal statement
  s(
    { trig = "tae", snippetType = "autosnippet" },
    fmt([[
  assert {} == {}
  ]],
      { i(1, "condition"), i(2, "value") }
    )
  ),

  -- Assert statement with pattern matching
  s(
    { trig = "tme", snippetType = "autosnippet" },
    fmt([[
  assert %{{ {} }} = {}
  ]],
      { i(1, "pattern"), i(2, "value") }
    )
  ),

}
return ok
-- vim: ts=2 sts=2 sw=2 et
