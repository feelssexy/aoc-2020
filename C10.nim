import strutils, algorithm, strformat, math

#let input = "28 33 18 42 31 14 46 20 48 47 24 23 49 45 19 38 39 11 1 32 25 35 8 17 7 9 4 2 34 10 3".split(" ")
#let input = @[1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19]
include inputloader

var sorted: seq[int] = @[0] # the wall outlet
for l in input:
  when input.typeof is seq[string]:
    sorted.add l.parseInt
  when input.typeof is seq[int]:
    sorted.add l
sorted.sort(cmp[int])
sorted.add sorted[^1] + 3   # the final built-in adapter

echo sorted

block puzzleOne:
  var oneCount, threeCount = 0
  var current = sorted[0]
  for i in 1..<sorted.len:
    case sorted[i] - current
    of 1:
      inc oneCount
    of 3:
      inc threeCount
    else:
      assert false, "i don't think this is allowed to happen"
    current = sorted[i]
  echo oneCount, " * ", threeCount, " = ", oneCount * threeCount

#block puzzleTwoBroken:
when false:
  var possibilities: int
  var toRemove: seq[int]
  var edited: seq[int]
  edited = sorted
  while true:
    var current = sorted[0]
    for i in 1..<edited.len:
      case edited[i] - current:
      of 1:
        inc possibilities
        if edited[i] notin toRemove:
          toRemove.add edited[i]
      of 2, 3:
        inc possibilities
      else:
        assert false, &"possibilities: {possibilities}, current: {current}, sorted[{i}]: {sorted[i]}"
      current = sorted[i]
    if toRemove == @[]:
      break # do while loop :white_check_mark: # racist!!
    edited.del edited.find(toRemove.pop())
    echo "removing ", toRemove[0]
  possibilities *= toRemove.len
  echo possibilities, " ", toRemove.len

block puzzleTwo:
  proc isValid(list: seq[int]): bool =
    var current = list[0]
    for i in 1..<list.len:
      if list[i] - current > 3:
        return false
      current = list[i]
    return true

  var possibilities: int
  var toRemove: seq[int] # indexes of `sorted`
  var edited: seq[int]   # a copy of `sorted` with changes
  var current = sorted[0]
  for i in 1..<sorted.len:
    # a case statement is not actually really needed here lole
    assert i >= 0
    case sorted[i] - current
    of 1, 2:
      assert sorted[i] notin toRemove
      assert i >= 0
      #toRemove.add sorted[i]
      toRemove.add i
    of 3:
      discard
    else:
      assert false, &"possibilities: {possibilities}, current: {current}, sorted[{i}]: {sorted[i]}"
    current = sorted[i]

  for i in 0..<2^toRemove.len:
    let activationTable = toBin(i, toRemove.len)

    edited = sorted#.deepCopy
    #echo edited
    for i, j in activationTable:
      assert i >= 0
      if j == '1':
        edited.del edited.find(sorted[toRemove[i]])
        #edited.del edited.find(toRemove[i])
    let sedited = edited.sorted
    if isValid(sedited):
      inc possibilities
    
  echo possibilities

  edited = sorted