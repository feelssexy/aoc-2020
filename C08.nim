import strutils#, tables

include inputloader

type Instructions = enum
  nop
  acc
  jmp

# Parse Input - is this even neccessary?
#var instructions: seq[Table[Instructions, int]]
var instructions: seq[(Instructions, int)]
for i in input:

  # could als be seperated using split(" ")
  #instructions.add {parseEnum[Instructions](i[0..2]): i[4..^1].parseInt}.toTable # works
  instructions.add (parseEnum[Instructions](i[0..2]), i[4..^1].parseInt) # works too

block puzzleOne:
  var runned: seq[int]
  var acc = 0
  var line = 0
  while line notin runned:
    runned.add line
    case instructions[line][0]
    of Instructions.nop:
      inc line
    of Instructions.acc:
      acc += instructions[line][1]
      inc line
    of Instructions.jmp:
      line += instructions[line][1]
  echo "line ", line, " is repeated", instructions[line]
  echo acc

block puzzleTwo:
  proc isStuck(instructions: seq[(Instructions, int)]): bool =
    var runned: seq[int]
    var acc = 0
    var line = 0
    while line notin runned and line < instructions.len:
      runned.add line
      #echo line, " ", instructions[line]
      case instructions[line][0]
      of Instructions.nop:
        inc line
      of Instructions.acc:
        acc += instructions[line][1]
        inc line
      of Instructions.jmp:
        line += instructions[line][1]
    if line in runned:
      result = true
    else:
      echo acc
  for n, i in instructions:
    if i[0] != Instructions.jmp:
      continue
    var altered = instructions
    altered[n] = (Instructions.nop, i[1])
    if not isStuck(altered):
      echo "try changing ", n, " ", instructions[n]
