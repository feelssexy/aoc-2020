import strutils

let input = open("C06.input").readAll().strip().splitLines()

block puzzleOne:
  #var counter = initCountTable[char]()
  var counter = 0
  var increased: seq[char]
  for line in input:
    if line.strip() == "":
      counter += increased.len
      increased = @[]
      continue
    for c in line:
      if c notin increased:
        increased.add c
  counter += increased.len
  echo counter
    
block puzzleTwo:
  func countThemUp(answers: seq[string], candidates: seq[char]): int =
    for c in candidates:
      block cc:
        for i in answers:
          if c notin i:
            break cc
        inc result
  var counter = 0
  var candidates: seq[char]
  var answers: seq[string]
  for line in input:
    if line.strip() == "":
      counter += countThemUp(answers, candidates)
      answers = @[]
      candidates = @[]
    else:
      answers.add line
      for c in line:
        if c notin candidates:
          candidates.add c
  counter += countThemUp(answers, candidates)
  echo counter