import regex, strutils

let input = open("C02.input").readAll().strip().split("\n")

template `[]`(m: RegexMatch, nGroup: string): string =
  m.group(nGroup, i)[0]

block puzzleOne:
  let expression = re"(?P<min>\d+)-(?P<max>\d+) (?P<letter>[a-z]): (?P<password>[a-z]+)"
  var valid = 0
  for i in input:
    var m: RegexMatch
    if i.match(expression, m):
      # for j in 0..<m.groupsCount:
      #  echo m.group(j, i)
      let letterCount = m["password"].count(m["letter"])
      if m["min"].parseInt <= letterCount and letterCount <= m["max"].parseInt:
        inc valid
    else:
      quit i & " did not match"
  echo "Valid: ", valid

block puzzleTwo:
  let expression = re"(?P<pos1>\d+)-(?P<pos2>\d+) (?P<letter>[a-z]): (?P<password>[a-z]+)"
  var valid = 0
  for i in input:
    var m: RegexMatch
    if i.match(expression, m):
      # for j in 0..<m.groupsCount:
      #  echo m.group(j, i)
      if $m["password"][m["pos1"].parseInt-1] == m["letter"] xor $m["password"][m["pos2"].parseInt-1] == m["letter"]:
        inc valid
    else:
      quit i & " did not match"
  echo "Valid: ", valid