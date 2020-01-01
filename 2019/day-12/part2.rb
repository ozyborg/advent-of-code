def process(data)
  history_x = {}
  history_y = {}
  history_z = {}

  x_index = -1
  y_index = -1
  z_index = -1

  index = 0

  loop do
    if x_index < 0
      key_x = data.flat_map { |m| m[0] }.join('.')
      if history_x[key_x]
        x_index = index
      else
        history_x[key_x] = true
      end
    end

    if y_index < 0
      key_y = data.flat_map { |m| m[1] }.join('.')
      if history_y[key_y]
        y_index = index
      else
        history_y[key_y] = true
      end
    end

    if z_index < 0
      key_z = data.flat_map { |m| m[2] }.join('.')
      if history_z[key_z]
        z_index = index
      else
        history_z[key_z] = true
      end
    end

    if x_index > 0 && y_index > 0 && z_index > 0
      break [x_index, y_index, z_index].reduce(1, :lcm)
    end

    res = {}

    4.times do |m|
      3.times do |p|
        res[[m, p]] = (0..3).inject(0) do |sum, x|
          sum + (data[x][p][0] <=> data[m][p][0])
        end
      end
    end

    res.each do |k, v|
      data[k[0]][k[1]][1] += v
      data[k[0]][k[1]][0] += data[k[0]][k[1]][1]
    end

    index += 1
  end
end

def input
  File.readlines('./input.txt').map do |line|
    line.strip[1..-2].split(', ').map do |p|
      [p.split('=').last.to_i, 0]
    end
  end
end

puts process(input)
