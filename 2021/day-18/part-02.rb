def calculate_depths(array)
  depths = []
  stack = []

  array.chars.each do |c|
    stack.push(c) if c == '['
    depths << [c.to_i, stack.size] if c.to_i.to_s == c
    stack.pop if c == ']'
  end

  depths
end

def reduce(depths)
  loop do
    applied_explode, applied_split = false, false

    i = 0

    while i != depths.size - 1
      if depths[i][1] >= 5 && (depths[i][1] == depths[i + 1][1])
        applied_explode = true

        depths[i - 1][0] += depths[i][0] if i > 0
        depths[i + 2][0] += depths[i + 1][0] if i + 2 < depths.size

        depth = depths[i][1]
        depths.delete_at(i)
        depths.delete_at(i)
        depths.insert(i, [0, depth - 1])

        i = 0
      else
        i += 1
      end
    end

    i = 0

    while i != depths.size
      if depths[i][0] >= 10
        applied_split = true

        e, d = depths.delete_at(i)

        depths.insert(i, [(e / 2.0).ceil, d + 1])
        depths.insert(i, [(e / 2.0).floor, d + 1])

        break i = 0
      else
        i += 1     
      end
    end

    break unless applied_explode || applied_split
  end

  depths
end

def calculate_magnitude(depths)
  i = 0

  until depths.one?
    if i < depths.size - 1 && depths[i][1] == depths[i + 1][1]
      left, l = depths.delete_at(i)
      right, l = depths.delete_at(i)
      depths.insert(i, [left * 3 + right * 2, l - 1])
      i = 0
    else
      i += 1
    end
  end

  depths.first.first
end

def process(data)
  data.combination(2).map do |d1, d2|
    depths = calculate_depths(d1) + calculate_depths(d2)
    depths.map! { |e, d| [e, d + 1] }
    calculate_magnitude(reduce(depths))
  end.max
end

def input
  File.readlines(ARGV.first)
end

puts process(input)
