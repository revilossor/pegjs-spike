{
  function evaluateEquality(left, right) {
    return options[left] === right
  }
}

start
  = equality

equality
  = left:predicate "==" right:predicate { return evaluateEquality(left, right) }
  / notequality

notequality
  = left:predicate "!=" right:predicate { return !evaluateEquality(left, right) }
  / logical_or

logical_or
  = left:logical_and "||" right:logical_or { return left || right }
  / logical_and

logical_and
  = left:primary "&&" right:logical_and { return left && right }
  / primary

primary
  = predicate
  / "(" logical_or:logical_or ")" { return logical_or; }

predicate
  = predicate:[a-zA-Z0-9]+ { return predicate.join(''); }
