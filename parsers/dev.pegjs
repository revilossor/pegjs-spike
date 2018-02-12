{
  function get(selector, object) {
    if(!object) { object = options }
    const split = selector.split('.')
    const value = object[split.shift()]
    if(!value) { return selector }
    return typeof value === 'object'
      ? get(split.join('.'), value)
      : value
  }
}

Clause 'clause'
  = left:Predicate operation:(_ ('&&' / 'AND' / '||' / 'OR') _ ) right:Predicate {
    switch(operation.join('').trim()) {
      case '&&':
      case "AND": return left && right; break;
      case '||':
      case 'OR': return left || right; break;
    }
  }
  / Predicate

Predicate 'predicate'
  = left:StateValue operation:(_ ('==' / '!=') _) right:StateValue {
    switch(operation.join('').trim()) {
      case '==': return left === right; break;
      case '!=': return left !== right; break;
    }
	}
  / MonoPredicate

MonoPredicate 'mono predicate'
  = key:StateValue {
    return key === true || key.toLowerCase() === 'yes'    // yes counts as true
  }

StateValue 'state value'    // assumes the String isnt a key in the state object
  = key:String {
    return get(key)
  }
  / String

String 'string'
	= chars:[a-zA-Z0-9\._-]+ {
    return chars.join('')
  }

_ 'whitespace'
 	= [ \t\n\r]*
