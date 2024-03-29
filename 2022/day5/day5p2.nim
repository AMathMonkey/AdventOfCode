import strutils
import sequtils
import sugar
import re

let lines = readFile("input.txt").splitLines
var initLines, numStacks: int

for i, line in lines:
  if '[' in line: continue
  let stackNums = line.split(" ").filterIt(it != "")
  initLines = i
  numStacks = stackNums[^1].parseInt
  break

var stacks = newSeq[seq[char]](numStacks)

for i in countdown(initLines - 1, 0):
  let
    line = lines[i]
    letters = collect:
      for i in countup(1, line.high, 4): line[i]
  for i, letter in letters:
    if letter != ' ': stacks[i].add(letter)


for line in lines[initLines + 2 .. ^1]:
  if line =~ re"move (\d+) from (\d+) to (\d+)":
    let
      num = matches[0].parseInt
      src = matches[1].parseInt - 1
      dest = matches[2].parseInt - 1
    stacks[dest].insert(stacks[src][^num .. ^1], stacks[dest].len)
    stacks[src].delete(stacks[src].len - num .. stacks[src].high)

echo stacks.mapIt(it[^1]).join