import itertools
import re

def input():
  return open('./input.txt', 'r').read().splitlines()

def process(data):
  count = 0

  for d in data:
    if re.search(r'([a-z][a-z])[a-z]*\1', d):
      if re.search(r'([a-z])[a-z]\1', d):
          count += 1

  return count

print(process(input()))
