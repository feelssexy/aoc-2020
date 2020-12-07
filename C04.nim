import strutils, tables, sequtils, regex

let raw_input = open("C04.input").readAll().strip().splitLines()

#[
# this is stupid and unneccessary for a simple script like this... or is it?
# it was easy to paste it in using this tho,, gam e  gmaing
type Keys = enum
  byr # (Birth Year)
  iyr # (Issue Year)
  eyr # (Expiration Year)
  hgt # (Height)
  hcl # (Hair Color)
  ecl # (Eye Color)
  pid # (Passport ID)
  cid # (Country ID)
]#

const needed = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"] # "cid" is not needed but also exists

type Passport = ref object
  # data: Table[Keys, string]
  data: Table[string, string]

# var passports: seq[Table[Keys, string]]

# proc initPassport: Passport = Passport(data: initTable[Keys, string]())

# Parsing
#var p = initPassport()
#var passports: seq[Passport]

var passports: seq[Table[string, string]]
block:
  var p = initTable[string, string]()

  for line in raw_input:
    if line == "":
      passports.add p
      p = initTable[string, string]()
    else:
      for i in line.split(" "):
        let i = i.split(":")
        assert i[0] notin p
        p[i[0]] = i[1]
  passports.add p

echo "--- PUZZLE ONE ---"

block puzzleOne:
  var validPassports = 0
  for passport in passports:
    # two other unfinished approaches that i tried bc i didn't know
    # that `toSeq` works on iterators
    #var amgood = 0
    #for i in passport.keys:
    #  if i in needed:
    #    inc amgood
    #if amgood == needed.len:
    ##########
    #var n = needed.toSeq
    #for i in passport.keys:
    #  assert i in n
    #  n.del(n.indexBy(i))
    #if n == @[]:
    ##########
    block b:
      for i in needed:
        if i notin toSeq(passport.keys):
          echo i, " is not in ", passport
          break b
      inc validPassports
  echo validPassports

echo "--- PUZZLE TWO ---"

#[
# how would i instantiate this with the values already in place?
#const regexChecks: Table[string, Regex] = Table(
  # testing for numeric ranges in regex :coolguy:
  "byr": re"(19[2-8][0-9]|199[0-9]|200[0-2])", # http://gamon.webfactional.com/regexnumericrangegenerator/ - i could've probably written this by myself anyways
  "iyr": re"20(1[0-9]|20)",
  "hgt": re"1([5-8][0-9]|9[0-3])cm|(59|6[0-9]|7[0-6])in",
  "hcl": re"#[0-9a-f]{6}",
  "ecl": re"amb|blu|brn|gry|grn|hzl|oth",
  "pid": re"[0-9]{9}",
  "cid": re".*"
)
]# ]#


var regexChecks: Table[string, Regex]
regexChecks["byr"] = re"(19[2-8][0-9]|199[0-9]|200[0-2])"
regexChecks["eyr"] = re"20(2[0-9]|30)"
regexChecks["iyr"] = re"20(1[0-9]|20)"
regexChecks["hgt"] = re"1([5-8][0-9]|9[0-3])cm|(59|6[0-9]|7[0-6])in"
regexChecks["hcl"] = re"#[0-9a-f]{6}"
regexChecks["ecl"] = re"amb|blu|brn|gry|grn|hzl|oth"
regexChecks["pid"] = re"[0-9]{9}"
regexChecks["cid"] = re".*"

#[
# i suggest you to uncomment this when working with it as nim's syntax highlighting happens to work wonderfully here
    byr (Birth Year) - four digits; at least 1920 and at most 2002.
    iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    hgt (Height) - a number followed by either cm or in:
        If cm, the number must be at least 150 and at most 193.
        If in, the number must be at least 59 and at most 76.
    hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    pid (Passport ID) - a nine-digit number, including leading zeroes.
    cid (Country ID) - ignored, missing or not.
]#

block puzzleTwo:
  var validPassports = 0
  for passport in passports:
    block b:
      for i in needed:
        if i notin toSeq(passport.keys) or not match(passport[i], regexChecks[i]):
          when true:
            if i notin toSeq(passport.keys):
              echo i, " is not in ", passport
            else:
              echo i, ": '", passport[i], "' does not match"
          break b
      inc validPassports
  echo validPassports