import strutils, strformat
#from sugar import collect

# using C13.input
include inputloader
let wantedTimestamp = input[0].parseInt
let busesRaw = input[1].split(',')

# just loading it myself
#let wantedTimestamp = "1008832".parseInt
#let busesRaw = "23,x,x,x,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,449,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,13,19,x,x,x,x,x,x,x,x,x,29,x,991,x,x,x,x,x,37,x,x,x,x,x,x,x,x,x,x,17".split(',')

# example because i probably need this
#let wantedTimestamp = "939".parseInt
#let busesRaw = "7,13,x,x,59,x,31,19".split(',')

#var buses: array[busesRaw.len, uint]

var buses = newSeqOfCap[int](busesRaw.len) # not all of the slots are going to be used
for i in busesRaw:
  if i == "x":
    continue
  buses.add i.parseInt


#let buses = collect(newSeqOfCap(buses.len)):


block puzzleOne:
  var smallest = int.high
  var bestBus = 0
  var i = 0
  for bus in buses:
    i = bus
    while i < smallest: # dumb method, no math capable brain required for this
      if i > wantedTimestamp:
        if i < smallest:
          smallest = i
          bestBus = bus
        break
      inc i, bus
  echo bestBus * (smallest - wantedTimestamp)

block puzzleTwoBroken: # dumb method once again
  break puzzleTwoBroken
  const stats = true
  var i, j = 0
  var highest, lastHighest = -1
  block bl:
    j = 0
    let b = buses[0]
    while true:
      for i, bus in busesRaw:
        when stats:
          if highest < i:
            highest = i
        if bus != $'x':
          if (b * j + i) == (bus.parseInt * j) and busesRaw.len == i+1:
            echo &"Let's have sex at {bus.parseInt * j}, shall we?"
            break bl
      inc j
      if highest > lastHighest:
        echo &"New highest: {highest} ayaya"
        lastHighest = highest

block yetAnotherTry:
  when false:
    var highest, l_highest = 0
  block all:
    for i in 0..10000000000:
    #for i in 1000000000..10000000000:
      block bl:
        for j, b in busesRaw:
          if b == "x":
            continue
          #if not (i == j * b.parseInt):
          if (i * buses[0] + j) mod b.parseInt != 0:
            break bl
          when false:
            if j > highest:
              highest = j
            if highest > l_highest:
              when true:
                echo &"New highest: {highest} got at timestamp"
              l_highest = highest
        echo &"Let's have sex at {i * buses[0]}, shall we?"
        break all

  block iterTest:
    break iterTest
    echo "commencing iter test"
    for i in 0..1000000000:
      discard
    echo "iter test done"


block puzzleTwo:
  break puzzleTwo
  var idx, b = 0
  var highest, l_highest = 0
  #for i, bus in busesRaw:
  for i in 0..100000000:
    if busesRaw[idx] != "x":
      b = busesRaw[idx].parseInt
      if i mod b == 0:
        inc idx
      else:
        idx = 0
    if idx+2 > len(busesRaw):
      echo "solverus, ", i * b
      break puzzleTwo
    if idx > highest:
      highest = idx
    if highest != l_highest:
      echo &"New highest {highest}"
      l_highest = highest