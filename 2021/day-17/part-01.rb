def process(data)
  x1, x2, y1, y2 = data

  ((y1.abs - 1) + 1) * (y1.abs - 1) / 2
end

def input
  [211, 232, -124, -69]
end

puts process(input)
