def build_map(data)
  data.each.with_object({}) do |d, map|
    d.each_cons(2) do |from, to|
      xs = from.zip(to)[0].sort
      ys = from.zip(to)[1].sort

      (xs.min..xs.max).each do |x|
        (ys.min..ys.max).each do |y|
          map[[x, y]] = '#'
        end
      end
    end
  end
end

def part_2(data)
  map = build_map(data)

  floor = map.keys.map(&:last).max + 2

  loop do
    sand = [500, 0]

    loop do
      if !map[[sand[0], sand[1] + 1]]
        sand[1] += 1
      elsif !map[[sand[0] - 1, sand[1] + 1]]
        sand[0] -= 1
        sand[1] += 1
      elsif !map[[sand[0] + 1, sand[1] + 1]]
        sand[0] += 1
        sand[1] += 1
      else
        break
      end

      break if floor - sand[1] == 1
    end

    map[sand] = 'o'

    break if sand == [500, 0]
  end

  map.values.count('o')
end

def part_1(data)
  map = build_map(data)

  abyss = map.keys.map(&:last).max + 1

  loop do
    sand = [500, 0]

    loop do
      if !map[[sand[0], sand[1] + 1]]
        sand[1] += 1
      elsif !map[[sand[0] - 1, sand[1] + 1]]
        sand[0] -= 1
        sand[1] += 1
      elsif !map[[sand[0] + 1, sand[1] + 1]]
        sand[0] += 1
        sand[1] += 1
      else
        break
      end

      break if sand[1] == abyss
    end

    break if sand[1] == abyss

    map[sand] = 'o'
  end

  map.values.count('o')
end

def input
  File.read('./inputs/14.txt').split("\n").map { |l| l.split(' -> ')
      .map { |ll| ll.split(',').map(&:to_i) } }
end

puts part_1(input)
puts part_2(input)
