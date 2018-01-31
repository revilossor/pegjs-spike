start
  = logical_or

logical_or
  = left:logical_and ws+ "||" ws+ right:logical_or { return left || right }
  / logical_and

logical_and
  = left:primary ws+ "&&" ws+ right:logical_and { return left && right }
  / primary

factor
  = "!" ws* operand:factor { return !operand }
  / primary

primary
  = token
  / "(" logical_or:logical_or ")" { return logical_or; }

token
  = token:[a-zA-Z0-9_]+ { return token.join('') === 'true'; }

ws
  = [ \t]
