--[[

Overview of Snippets for Elixir

  Basics
  - ppr => print()
  - ppc => cat()
  - ppm => message()
  - pph => head()
  - ppt => tail()
  - aao => <- 
  - llb => library()
  - ssr => source()
  - cq  => c() 


  Pipe Snippets
  - ;p => Pipe on new line
  - dmp => Pipe into mutate()
  - dfp => Pipe into filter()
  - dsp => Pipe into summarise()
  - dlp => Pipe into select()
  - djl => Pipe into left_join()
  - djr => Pipe into right_join()
  - djf => Pipe into full_join()
  - dmp => Pipe into mutate()


  dplyr Programming
  - mD => dplyr::
  - daa => across()
  - dvv => everything()
  - dbb => bracing {{ }}
  - dww => where()
  - dws => start_with()
  - dwe => ends_with()
  - dcc => contains()
  - ddp => .data[]

  tidyr
  - mT => tidyr::
  - tpl => pivot_longer()
  - tpw => pivot_wider()

  ggplot2 Programming
  - mG => ggplot2::
  - ggm => geom_
  - ggt => stat_
  - ggs => scale_
  - ggf => facet_
  - gga => aes()

  Conditionals
  - iif => If statement
  - ifel => If else statement
  - ccd => Cond Structure
  - ccs => Case Structure

  Definitions


  Testing
  - tcc => Define Test Block
  - taa => Assert statement with Equality
  - tae => Assert statement with Error



--]]

local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require 'luasnip.extras'
local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt

return {

  --INFO: Basics
  --
  -- print
  s({ trig = 'ppr', snippetType = 'autosnippet' }, fmt('print({})', { i(1, '...') })),

  -- cat
  s({ trig = 'ppc', snippetType = 'autosnippet' }, fmt('cat({})', { i(1, '...') })),

  -- message
  s({ trig = 'ppm', snippetType = 'autosnippet' }, fmt('message({})', { i(1, '...') })),

  -- head
  s({ trig = 'pph', snippetType = 'autosnippet' }, fmt('head({})', { i(1, '...') })),

  -- tail
  s({ trig = 'ppt', snippetType = 'autosnippet' }, fmt('tail({})', { i(1, '...') })),

  -- assign operator <-
  s(
    { trig = 'aao', snippetType = 'autosnippet' },
    fmt(
      [[
   {} <- {}
   ]],
      { i(1, 'new_variable'), i(2, 'value') }
    )
  ),

  -- library
  s({ trig = 'llb', snippetType = 'autosnippet' }, fmt([[library({})]], { i(1, 'package') })),

  -- source
  s({ trig = 'ssr', snippetType = 'autosnippet' }, fmt([[source({})]], { i(1, 'path') })),

  -- c()
  s({ trig = 'cq', snippetType = 'autosnippet' }, fmt([[c({})]], { i(1, 'array') })),

  --INFO: Pipe Snippets
  --
  -- Pipe Character
  s(
    { trig = ';p', snippetType = 'autosnippet' },
    fmt(
      [[ 
      |>
    {}
    ]],
      { i(1) }
    )
  ),
}
