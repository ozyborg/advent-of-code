def process(data)
  x, y = 0, 0
  w_x, w_y = 10, 1

  data.each do |instruction|
    action, unit = instruction

    case action
    when 'F'
      x += w_x * unit
      y += w_y * unit
    when 'L'
      (unit / 90).times do
        w_x, w_y = -w_y, w_x
      end
    when 'R'
      (unit / 90).times do
        w_x, w_y = w_y, -w_x
      end
    when 'N'
      w_y += unit
    when 'S'
      w_y -= unit
    when 'E'
      w_x += unit
    when 'W'
      w_x -= unit
    else
    end
  end

  x.abs + y.abs
end

def input
  File.read('./input.txt').scan(/([NSEWLRF]{1})(\d+)\s?/).map do |instruction|
    [instruction[0], instruction[1].to_i]
  end
end

puts process(input)
