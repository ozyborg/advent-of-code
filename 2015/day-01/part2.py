def input():
  return list(open('./input.txt', 'r').read().strip())

def process(data):
  floor, position = 0, 0

  ch_to_i = { '(': 1, ')': -1 }

  for i, ch in enumerate(data):
    floor += ch_to_i[ch]

    if floor < 0:
      position = i + 1
      break

  return position

print(process(input()))
