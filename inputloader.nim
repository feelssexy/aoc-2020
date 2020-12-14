import os, strutils

when isMainModule:
  # assumes the binary is prepended with a dot like the `nimc` alias always does
  let inputFilename = getAppFilename().splitFile()[1][1..^1] & ".input"
  let input = open(inputFilename).readAll.strip.splitLines