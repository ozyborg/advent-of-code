def process(data)
  x1, x2, y1, y2 = data

  x_range = (1..x2).to_a
  y_range = (y1..(y1.abs - 1)).to_a

  x_range.product(y_range).count do |x, y|
    pos_x, pos_y = 0, 0

    (1..).each do |t|
      pos_x += (x - t + 1).clamp(0, x)
      pos_y -= (t - y - 1)

      break false if pos_x > x2 || pos_y < y1
      break true if pos_x.between?(x1, x2) && pos_y.between?(y1, y2)
    end
  end
end

def input
  [211, 232, -124, -69]
end

puts process(input)
