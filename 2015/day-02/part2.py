import math

def input():
  return list(
    map(
      lambda line: [int(d) for d in line.strip().split('x')],
      open('./input.txt', 'r').readlines()
    )
  )

def required_ribbon(dimensions):
  return 2 * sum(sorted(dimensions)[:2]) + math.prod(dimensions)

def process(data):
  return sum(map(required_ribbon, data))

print(process(input()))
