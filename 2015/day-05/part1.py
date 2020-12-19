import itertools
import re

def input():
  return open('./input.txt', 'r').read().splitlines()

def process(data):
  count = 0

  for d in data:
    if len(re.findall(r'[aeiou]', d)) >= 3:
      if re.search(r'([a-z])\1', d):
        if len(re.findall(r'ab|cd|pq|xy', d)) == 0:
          count += 1

  return count

print(process(input()))
