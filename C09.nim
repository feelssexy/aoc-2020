
import strutils

#include inputloader
let input = """35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576""".splitLines

var parsed: seq[int]
for i in input:
  parsed.add i.parseInt

block puzzleOne:
  proc findSum(what: int, options: openarray[int]): bool =
    for i in options:
      for j in options:
        if (i + j) == what:
          return true

  let preambleLength = 5
  for i, line in input:
    if i > preambleLength:
      discard
    let pparsed = parsed[0..<i]
    if not findSum(line.parseInt, pparsed): # 
      echo i, ' ', line, " - ", pparsed
