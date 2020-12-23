import strformat, regex

#include inputloader
let input = @["F10", "N3", "F7", "R90", "F11"]

# stupid doesnt work
#const r_expr = re"""(?x)
#(
#  ?P<instruction>
#  [NSEWLFR]
#)
#(
#  ?P<amount>
#  \d+
#)
#"""

#const r_expr = re"""(?x)
#(?P<instruction>[NSEWLFR])
#(?P<amount>\d+)
#"""

const r_expr = re"(?P<instruction>[NSEWLFR])(?P<amount>\d+)"

for line in input:
  var m: RegexMatch
  assert match(line, r_expr, m)
  #echo m.group("amount", line)