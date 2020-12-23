import strutils, strformat

let input = """L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL""".splitlines

# why is it seat states... shouldn't it be a seat with an x and y coordinate........... stupid
# also that unnceessarily logn comamnd is stupid
type Seat = enum
  empty, floor, occupied, outside

proc getSeat(x, y: int, noWarning = false): Seat =
  try:
    # could replace this case statement with a mapping/table
    # (me trying hard to come over as cool and hip by using random datatype words sfsdsh)
    # ((me trying to be 2cool4skool by being forcefully [gezwungen] self-reflective))
    #echo input[y][x]
    case input[y][x]
    of 'L':
      return Seat.empty
    of '.':
      return Seat.floor
    of '#':
      return Seat.occupied
    else:
      assert false
  except IndexDefect:
    if not noWarning:
      echo &"Coordinates ({x}, {y}) outside of boundaries"
    #return Seat.floor
    return Seat.outside

proc drawSeats(seats: seq[seq[Seat]]): string =
  for i in seats:
    for j in i:
      case j
      of Seat.empty:
        result.add 'L'
      of Seat.floor:
        result.add '.'
      of Seat.occupied:
        result.add '#'
      else:
        assert false
    result.add '\n'
  result = result.strip

type SeatAdjacents = object
  #empty, floor, occupied: 0..8
  empty, floor, occupied, outside: -1..9
  #empty, floor, occupied, outside: int
  #empty, floor, occupied, outside: -100..100

proc countAdjacents(x, y: int): SeatAdjacents =
  #template a(x: Seat, i: -1|1) =
  template a(x: Seat, n: -1..1) =
    case x:
    of Seat.empty:
      result.empty += n
    of Seat.floor:
      result.floor += n
    of Seat.occupied:
      result.occupied += n
    else:
      result.outside += n
  try:
    for i in -1..1:
      for j in -1..1:
        a(getSeat(x+i, y+j, true), 1)
    a(getSeat(x, y), -1)
  except OverflowDefect:
    quit &"OverflowDefect {result=} {x=} {y=}"

# is this parsing really neccessary omg
var parsed: seq[seq[Seat]]
for i in 0..<input.len:
  parsed.add newSeqOfCap[Seat](input[0].len)
  for j in 0..<input[i].len:
    parsed[i].add getSeat(j, i)

block puzzleOne:
  var cycles = 0
  var iHateBeing: seq[seq[Seat]] = parsed
  var newAndImproved = iHateBeing
  while true:
    echo newAndImproved == iHateBeing
    newAndImproved = iHateBeing.deepCopy
    for i, a in parsed:
      for j, b in a:
        let adjacents = countAdjacents(i, j)
        echo adjacents.occupied
        if b == Seat.empty:
          if adjacents.occupied == 0:
            newAndImproved[i][j] = Seat.occupied
        elif b == Seat.occupied:
          if adjacents.occupied >= 4:
            newAndImproved[i][j] = Seat.empty
    inc cycles
    if newAndImproved == iHateBeing:
      break
    iHateBeing = newAndImproved.deepCopy

  echo drawSeats(newAndImproved)
  echo "total cycles: ", cycles