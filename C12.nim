import strformat, regex, strutils

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

const r_expr = re"""(?x)
(:?(?P<direction>[NESW])|(?P<rdirection>[LFR]))
(?P<amount>\d+)
"""

type Direction {.pure.} = enum
  dNorth, dEast, dSouth, dWest

#type A = enum
#  dEast, smthelse

proc newDirection(c: char | string): Direction =
  case $c
  of "N":
    return Direction.dNorth
  of "E":
    return Direction.dEast
  of "S":
    return Direction.dSouth
  of "W":
    return Direction.dWest
  else:
    raise ValueError("Letter can only be N, E, S, W; not " & $c)

type Instruction = enum
  north, east, south, west
  left, right
  forward

proc funny(a: tuple[funny: int]): int = 2
proc funny(a: tuple[a: int]): int = 3

var d = (funny: 1)
echo d.funny()
#inc d
#echo d

quit 0

for line in input:
  var m: RegexMatch
  assert match(line, r_expr, m)
  #echo m.group("amount", line)

#block puzzleOne:
#  var direction: Direction = Direction.dEast
#  var m: RegexMatch
#  for line in input:
#    assert match(line, r_expr, m)

block puzzleOne: # quick and 'dirty'
  template parseDirection(position: var typed, a: char, n: int) =
    case a
    of 'N':
      position.y -= n
    of 'E':
      position.x += n
    of 'S':
      position.y += n
    of 'W':
      position.x -= n
    else:
      assert false, &"instruction '{instruction}' cannot exist, I ignorantly deny its existance... look at all the unfacutal proof"
  var facing: char = 'E'
  var m: RegexMatch
  var position = (x: 0, y: 0)
  for line in input:

    let instruction = line[0]
    let number = line[1..^1].parseInt
    case instruction
    of 'F':
      parseDirection(position, facing, number)
    of 'R':
      assert (number mod 90) == 0, &"instruction: {instruction}, number: {number}"

    of 'L':
      discard
    else:
      parseDirection(position, facing, number)
  echo &"Ship's Position: ({position.x}, {position.y})"
      