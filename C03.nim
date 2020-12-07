# !!! unfinished, fuck

import strutils

let text = open("C03.input").readAll().strip().split("\n")

# var input: seq[seq[char]]
# for i, j in text:
#   input.add newSeq[char]()
#   for k, l in j:
#     input[i].add l

# let input = text
let input = """..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#""".strip().split("\n")

proc coord(x, y: int): char =
  var a: string
  if y < input.high:
    a = input[y]
  else:
    return ' '
  # if x < a.high:
  if false:
    return a[x]
  else:
    var i = x
    var substract: int
    while i > 0:
      # if (i mod (a.len-1)) == 0:
      if (i mod (a.len)) == 0:
        substract = i
        # echo substract
        break
      dec i
    return a[x-substract]

block puzzleOne:
  var trees = 0
  var x, y = 0
  while y <= len(input):
  # for i in 1..10:
    if coord(x, y) == '#':
      inc trees
    var substract: int
    block:
      var i = x
      while i > 0:
        # if (i mod (a.len-1)) == 0:
        if (i mod 11) == 0:
          substract = i
          # echo substract
          break
        dec i
    stdout.write coord(x, y); stdout.flushFile
    #echo coord(x, y), ' ', x, ' ', y, ' ', substract
    inc x, 3
    inc y, 1
  echo ""
  echo trees

# for i in input:
#   for j in i:
#     stdout.write(j)
#   echo ""