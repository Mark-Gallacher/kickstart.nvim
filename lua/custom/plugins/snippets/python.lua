return {

  -- print
  s(
    'print',
    fmt(
      [[
print({})
  ]],
      { i(1, '...') }
    )
  ),

  -- print with f string
  s(
    'fprint',
    fmt(
      [[
print(f"{}:{{ {} }}")
  ]],
      { i(1, '...'), i(2, '...') }
    )
  ),

  -- multiline string
  -- """ """
  s('mlc', { t '"""', i(1), t '"""', i(0) }),

  -- magic method
  -- __init__(self, ):
  s('mm', { t '__', i(1, 'init'), t '__(self,', i(2), t { '):', '\t' }, i(0) }),

  -- magic function
  -- __init__():
  s('mf', { t '__', i(1, 'init'), t '__(', i(2), t { '):', '\t' }, i(0) }),

  -- if __name__ == "__main__":
  s('nem', { t { 'if __name__ == "__main__":', '\t' }, i(0, 'main()') }),

  -- import
  s('imp', { t 'import ', i(1) }),

  -- import ... as ...
  s('ima', { t 'import ', i(1), t ' as ', i(2) }),

  -- from ... import ...
  s('fmp', { t 'from ', i(1), t ' import ', i(2) }),

  -- if statement
  s('if', { t 'if ', i(1, 'cond'), t { ':', '\t' }, i(2, '...') }),

  -- else statement
  s('els', { t { 'else:', '\t' }, i(1, '...') }),

  -- if else statement
  s(
    'elif',
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
    'elif',
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
    'for',
    fmt(
      [[
    for {} in {}:
        {}]],
      { i(1, 'item'), i(2, 'items'), i(3, '...') }
    )
  ),

  -- for loops with range
  s(
    'forr',
    fmt(
      [[
  for {} in range({}):
      {}]],
      { i(1, 'item'), i(2, 'items'), i(3, '...') }
    )
  ),
  -- with
  s(
    'with',
    fmt(
      [[
with {} as {}:
    {}]],
      { i(1, 'expression'), i(2, 'alias'), i(3, '...') }
    )
  ),
  -- lambda
  s(
    'lambda',
    fmt(
      [[
lambda {}: {}
]],
      { i(1, 'arg'), i(2, 'expression') }
    )
  ),

  -- function definition
  s(
    'def',
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
    'deft',
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
    'mdef',
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
    'mdeft',
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

  -- Class
  s(
    'cld',
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
    'except',
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
    'exceptas',
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
    'tryexcept',
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
    'exceptraise',
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
    'tryexceptfinally',
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
  s(
    'listcomp',
    fmt(
      [=[
[{4}{3} for {1} in {2}]
]=],
      { i(1, 'item'), i(2, 'items'), rep(1), i(3) }
    )
  ),

  -- isinstance
  s(
    'isin',
    fmt(
      [[
isinstance({}, {})
]],
      { i(1, 'variable'), i(2, 'type') }
    )
  ),
}
