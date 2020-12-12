def next_x_y(action, x, y, unit)
  next_x, next_y = x, y

  case action
  when 'N'
    next_y += unit
  when 'S'
    next_y -= unit
  when 'E'
    next_x += unit
  when 'W'
    next_x -= unit
  end

  [next_x, next_y]
end

def process(data)
  x, y = 0, 0
  direction = 'E'
  compass = %w(N E S W N E S W)

  data.each do |instruction|
    action, unit = instruction

    case action
    when 'F'
      x, y = next_x_y(direction, x, y, unit)
    when 'L'
      direction = compass[compass.index(direction) - (unit / 90)]
    when 'R'
      direction = compass[compass.index(direction) + (unit / 90)]
    else
      x, y = next_x_y(action, x, y, unit)
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
