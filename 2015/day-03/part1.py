def input():
  return list(open('./input.txt', 'r').read().strip())

def process(data):
  x, y = 0, 0
  points = { (x, y) }

  for ch in data:
    if ch == '^':
      y += 1
    if ch == 'v':
      y -= 1
    if ch == '>':
      x += 1
    if ch == '<':
      x -= 1
    points.add((x, y))

  return len(points)

print(process(input()))
