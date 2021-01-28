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
  echo "Part 1"
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
  proc turnShip(f: var char, n: int) =
    const cycle = "NESW"
    assert f in cycle, "Only valid options are " & cycle[0..^2].join(", ") & " and " & cycle[^1]
    assert n mod 90 == 0, "Must be dividable by 90"
    var i = n
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
      f = cycle[^i]
  var facing: char = 'E'
  var position = (x: 0, y: 0)
  for line in input:
    let instruction = line[0]
    let number = line[1..^1].parseInt
    case instruction
    of 'F':
      parseDirection(position, facing, number)
    of 'R':
      facing.turnShip(number)
    of 'L':
      facing.turnShip(-number)
    else:
      parseDirection(position, instruction, number)
    #echo &"{instruction}{number}{' '.repeat(3 - len($number))}: ({position.x}, {position.y})  F: {facing}"
  echo &"Ship's Position: ({position.x}, {position.y})"
  echo &"Manhattan's Distance: {abs(position.x) + abs(position.y)}"

block puzzleTwo:
  echo "Part 2"
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
  var waypointPos = (x: 10, y: -1)
  var shipPos = (x: 0, y: 0)
  for line in input:
    let instruction = line[0]
    let number = line[1..^1].parseInt
    case instruction
    of 'F':
      shipPos.x += waypointPos.x * number
      shipPos.y += waypointPos.y * number
    of 'R':
      assert number mod 90 == 0
      for i in 1..(number/90).int:
        (waypointPos.x, waypointPos.y) = (-waypointPos.y, waypointPos.x)
        #(waypointPos.x, waypointPos.y) = (-waypointPos.y, -waypointPos.x)
    of 'L':
      assert number mod 90 == 0
      for i in 1..(number/90).int:
        (waypointPos.x, waypointPos.y) = (waypointPos.y, -waypointPos.x)
    else:
      parseDirection(waypointPos, instruction, number)
    #echo &"{instruction}{number}{' '.repeat(3 - len($number))}: W({waypointPos.x}, {waypointPos.y}) S({shipPos.x}, {shipPos.y})"#  F: {facing}"
  echo &"Ship's Position: ({shipPos.x}, {shipPos.y})"
  echo &"Manhattan's Distance: {abs(shipPos.x) + abs(shipPos.y)}"