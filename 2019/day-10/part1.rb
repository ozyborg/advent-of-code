def process(data)
  y_size = data.size
  x_size = data.first.size
  visibles_for_positions = {}

  y_size.times do |y|
    x_size.times do |x|
      next if data[y][x] == '.'

      visible_positions = []

      y_size.times do |j|
        x_size.times do |i|
          next if data[j][i] == '.'
          next if i == x && j == y

          d_y = y - j
          d_x = x - i

          step = d_y.gcd(d_x)
          step_y = d_y / step
          step_x = d_x / step

          current_y = y
          current_x = x

          is_visible = loop do
            current_y -= step_y
            break true if current_y < 0 || current_y >= y_size
            current_x -= step_x
            break true if current_x < 0 || current_x >= x_size 
            break true if current_x == i && current_y == j
            break false if data[current_y][current_x] == '#'
          end
          visible_positions << [i, j] if is_visible
        end
      end

      visibles_for_positions[[x, y]] = visible_positions
    end
  end

  visibles_for_positions.values.map(&:size).max
end

def input
  File.readlines('./input.txt').map{|line| line.strip.split('')}
end

puts process(input)
