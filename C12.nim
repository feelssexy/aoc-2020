import strformat, regex, strutils

include inputloader
#let input = @["F10", "N3", "F7", "R90", "F11"]

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
  #proc turnShip(f: var {'N', 'E', 'S', 'W'}, n: int) =
  proc turnShip(f: var char, n: int) =
    var i = n
    const cycle = "NESW"
    #while i > 270: # 90 * 4 - 90
    #  assert false, $i
    #  i -= 90
    i = (i / 90).int
    i += cycle.find(f)
    while i > 3:
      echo "aa"
      i -= 4
    while i < 0:
      echo "bb"
      i += 4
    if i >= 0:
      f = cycle[i]
    else:
      #inc i, 2
      #echo "fucked"
      #echo cycle
      #echo i
      #echo cycle[^i]
      f = cycle[^i]
  template ass =
    assert (number mod 90) == 0, &"instruction: {instruction}, number: {number}"
  var facing: char = 'E'
  var position = (x: 0, y: 0)
  for line in input:
    let instruction = line[0]
    let number = line[1..^1].parseInt
    case instruction
    of 'F':
      parseDirection(position, facing, number)
    of 'R':
      ass()
      facing.turnShip(number)
    of 'L':
      ass()
      facing.turnShip(-number)
    else:
      parseDirection(position, instruction, number)
    echo &"{instruction}{number}{' '.repeat(3 - len($number))}: ({position.x}, {position.y})  F: {facing}"
  echo &"Ship's Position: ({position.x}, {position.y})"
  echo &"Manhattan's Distance: {abs(position.x) + abs(position.y)}"
      