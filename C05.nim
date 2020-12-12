import strutils, math, tables, sequtils

let input = open("C05.input").readAll().strip().splitLines()
#let input = ["BFFFBBFRRR"]

type
  Seat = object
    row, column: uint8

# extra uint8 zu nutzen ist wahrscheinlich etwas unnoetig /shrug
func seatId(seat: Seat): uint =
  #seat.row * 8_u8 + seat.column
  uint(seat.row) * 8 + seat.column

func seatId(row, column: uint8): uint =
  seatId(Seat(row: row, column: column))

#func getSeat(seatCode: array[10, char]): Seat =
func getSeat(seatCode: string): Seat =
  assert seatCode.len == "FBFBBFFRLR".len
  const totalRows = 128
  var r = newSeqOfCap[uint8](totalRows)
  for i in 0..<totalRows:
    r.add uint8(i)

  const totalColumns = 8
  var c = newSeqOfCap[uint8](totalColumns)
  for i in 0..<totalColumns:
    c.add uint8(i)
    
  # i should be in bed already (2:41), so i'm not gonna
  # waste time on a super amazing cool thingy algorythm
  # and instead just use a dumb way.. actually, i
  # probably wouldn't have made a nice and fantastic
  # and amazing algorythm if it wasn't late
  # ldfkgjhh mhhhhhhhhhhhhhh hmmmmmmmmmm........ fuck me
  #for i, j in seatCode[0..6]: # row
  for i, j in seatCode: # row
    let rhalf = toInt(r.len/2)
    let chalf = toInt(c.len/2)
    #let half = (m.len-1)/2
    #if m[^1] == 0 and seatCode[0..6] != "FFFFFF":
    if r[^1] == 0:
      assert r[0..^2] != r
      ##debugecho "OK THEN"
      #m = m[0..^2]
    case j
    of 'F':
      ##debugecho half
      r = r[0..<rHalf]
    of 'B':
      #m = m[m.len/2..m.len-1]
      ##debugecho half
      r = r[rhalf..^1]
    of 'L':
      c = c[0..<chalf]
    of 'R':
      c = c[chalf..^1]
    else:
      assert false, $j & ": " & $i
    ##debugecho j, m
  

  ##debugecho "Final: ", m
  result.row = r[0]
  result.column = c[0]


block puzzleOne:
  var highestId = -1
  for line in input:
    let a = seatId(getSeat(line))
    if int(a) > highestid:
      highestId = int(a)
      echo "newest highest with ", a
  echo highestId

block puzzleTwo:
  var rows, columns, full: seq[string]
  #var seatIds: Table[uint, string]
  var seatStrings: Table[uint, Seat] # false name
  # generating binary strings and then using multiReplace on it
  # is probably unefficient, but who cares? what am i even saying
  for i in 0 ..< 2^7:
    rows.add i.toBin(7).multiReplace(("0", "F"), ("1", "B"))
  for i in 0 ..< 2^3:
    columns.add i.toBin(3).multiReplace(("0", "L"), ("1", "R"))
  
  # both in the same sequence
  for i in rows:
    for j in columns:
      full.add i & j
  
  for i in full:
    #seatIds[seatId(getSeat(i))] = i
    seatStrings[seatId(getSeat(i))] = getSeat(i)

  #let toBeFound = (892, 891, 893)
  let toBeFound = [892, 891, 893]
  
  for i in toBeFound:
    if uint(i) notin toSeq(seatStrings.keys()):
      continue
    echo i, ": ", seatStrings[uint(i)]