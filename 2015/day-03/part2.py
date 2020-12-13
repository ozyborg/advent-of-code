def input():
  return list(open('./input.txt', 'r').read().strip())

def process(data):
  sx, sy = 0, 0
  rx, ry = 0, 0
  points = { (sx, sy), (rx, ry) }

  for i, ch in enumerate(data):
    if ch == '^':
      if i % 2 == 0:
        sy += 1
      else:
        ry += 1
    if ch == 'v':
      if i % 2 == 0:
        sy -= 1
      else:
        ry -= 1
    if ch == '>':
      if i % 2 == 0:
        sx += 1
      else:
        rx += 1
    if ch == '<':
      if i % 2 == 0:
        sx -= 1
      else:
        rx -= 1

    points.add((sx, sy))
    points.add((rx, ry))

  return len(points)

print(process(input()))
