import tables, regex, sequtils

include inputloader
import strutils
#let input = """light red bags contain 1 bright white bag, 2 muted yellow bags.
#dark orange bags contain 3 bright white bags, 4 muted yellow bags.
#bright white bags contain 1 shiny gold bag.
#muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
#shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
#dark olive bags contain 3 faded blue bags, 4 dotted black bags.
#vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
#faded blue bags contain no other bags.
#dotted black bags contain no other bags.""".splitLines

#let input = """shiny gold bags contain 2 dark red bags.
#dark red bags contain 2 dark orange bags.
#dark orange bags contain 2 dark yellow bags.
#dark yellow bags contain 2 dark green bags.
#dark green bags contain 2 dark blue bags.
#dark blue bags contain 2 dark violet bags.
#dark violet bags contain no other bags.""".splitLines


# not 100% exact because of ',' and '.' and maybe other reasons i may not realize
# "2 shiny gold bag" would match... only a complete lunatic would make sure that it doesn't match 
#const re_expr = re"([\w ]+) bags contain (?:(?:(\d [\w ]+)bags?,?)*|(no other bags))\."
const re_expr = re"([\w ]+) bags contain (?:(?:(\d [\w ]+) bags?(?:. )?)*|(no other bags))\."

type RulesTable = Table[string, Table[string, int]]
#var rules: Table["string", Table[string, int]]
var rules = RulesTable()

# parse rules
var match: RegexMatch
#for line in input[0..2]:
for line in input:
  if line.match(re_expr, match):
    #for i in 0..<len(match.captures):
    #  echo group(match, i, line)
    assert group(match, 0, line).len == 1
    let key = group(match, 0, line)[0]
    rules[key] = initTable[string, int]()
    if group(match, 2, line) == @[]:
      for i in group(match, 1, line):
        # the function call in assert also implicitly defines the `match` var
        assert i.match(re"([0-9]+) ([\w ]+)", match) == true and len(group(match, 0, line)) == 1
        rules[key][group(match, 1, i)[0]] = group(match, 0, i)[0].parseInt
    else:
      discard

const cache = false
when cache:
  echo "using cache"
when not cache:
  echo "not using cache"
block puzzleOne:
  var weirdCache = initTable[string, bool]()
  var count = 0
  proc getInRecursion(rulesTable: RulesTable, path: string): seq[string] =
    for k, v in rulesTable[path].pairs:
      result.add k
      result.add getInRecursion(rulesTable, k)

  proc shinyRecursionCheck(rulesTable: RulesTable, path: string): bool =
    var k: string
    for k, v in rulesTable[path].pairs:
      when cache:
        if weirdCache.hasKey(k):
          #echo "used cache, damn"
          return weirdCache[k]
      if k == "shiny gold":
        result = true
      else:
        result = shinyRecursionCheck(rulesTable, k)
        when cache:
          weirdCache[k] = result
      if result:
        return result
        
      
  var t = ""
  for k, v in rules.pairs:
    t = k
    assert rules.hasKey(k)
    discard
    #while rules[t] != initTable[string, int]():
  for i in rules.keys:
    #echo i, ": ", shinyRecursionCheck(rules, i)
    #echo shinyRecursionCheck(rules, i)
    if shinyRecursionCheck(rules, i):
      inc count

  stderr.writeLine $count

block puzzleTwo:
  var count = 0
  proc countInRecursion(rulesTable: RulesTable, bag: string): int =
    var multiplier: seq[int]
    func product(numbers: seq[int]): int =
      result = 1
      for n in numbers:
        result = n * result
    proc recurse(rulesTable: RulesTable, bag: string): int =
      for k, v in rulesTable[bag].pairs:
        multiplier.add v
        result += product(multiplier)
        result += recurse(rulesTable, k)
        multiplier.del(multiplier.high)
    recurse(rulesTable, bag)
  
  #for i in rules.keys:
  #  count += getInRecursion(rules, i)
  count += countInRecursion(rules, "shiny gold")
    
  stderr.writeLine $count