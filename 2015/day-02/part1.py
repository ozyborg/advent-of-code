def input():
  return list(
    map(
      lambda line: [int(d) for d in line.strip().split('x')],
      open('./input.txt', 'r').readlines()
    )
  )

def required_wrapping_paper(dimensions):
  areas = [
    dimensions[0] * dimensions[1],
    dimensions[0] * dimensions[2],
    dimensions[1] * dimensions[2]
  ]

  return 2 * sum(areas) + min(areas)

def process(data):
  return sum(map(required_wrapping_paper, data))

print(process(input()))
