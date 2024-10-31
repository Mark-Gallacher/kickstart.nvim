return {

  -- basic code snippet form
  s(
    'sniptemp',
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
        i(1, 'trigger'),
        i(2, 'string'),
        i(3, 'nodes'),
      }
    )
  ),

  -- multiline comment
  s(
    'mlc',
    fmt(
      [=[ 
  [[ 
  {} 
  ]] 
  ]=],
      { i(1) }
    )
  ),
}
