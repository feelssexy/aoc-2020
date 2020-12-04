import strutils

let text = open("C03.input").readAll().strip().split("\n")

# var input: seq[seq[char]]
# for i, j in text:
#   input.add newSeq[char]()
#   for k, l in j:
#     input[i].add l

let input = text

proc coord(x, y: int): char =
  var a: string
  var substract: int
  try:
    if y < input.high:
      a = input[y]
    else:
      return ' '
    if x < a.high:
      return a[x]
    else:
      # echo "oo"
      var i = a.high
      while i > 0:
        if (x mod i) == 0:
          substract = x
          break
        dec i
      return a[x-substract]
  except IndexDefect as e:
    echo ' '
    echo x, ' ', y
    echo substract
    raise e

block puzzleOne:
  var
    x = 1
    y = 1
  while y <= len(input):
  # for i in 1..10:
    # stdout.write coord(x, y); stdout.flushFile
    echo coord(x, y), ' ', x, ' ', y
    inc x, 1
    inc y, 3
  echo ""

# for i in input:
#   for j in i:
#     stdout.write(j)
#   echo ""