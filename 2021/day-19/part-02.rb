def position(s1, s2)
  s1.product(s2).map.with_object({}) do |c, obj|
    v = c.transpose.map { |c1, c2| c1 - c2 }
    obj[v] = obj.fetch(v, 0) + 1
  end.key(12)
end

def arrangements(s)
  s.map do |x, y, z|
    [x, y, z].permutation(3).to_a +
    [x * -1, y, z].permutation(3).to_a +
    [x, y * -1, z].permutation(3).to_a +
    [x, y, z * -1].permutation(3).to_a +
    [x * -1, y * -1, z].permutation(3).to_a +
    [x * -1, y, z * -1].permutation(3).to_a +
    [x, y * -1, z * -1].permutation(3).to_a +
    [x * -1, y * -1, z * -1].permutation(3).to_a
  end.transpose
end

def process(data)
  scanners = [data.shift]
  positions = [[0, 0, 0]]

  until data.empty?
    data.each.with_index do |s, i|
      arrangements(s).each do |arr|
        scanners.each do |scanner|
          pos = position(scanner, arr)
          if pos
            positions << pos
            scanners << arr.map { |arr_pos| arr_pos.zip(pos).map(&:sum) }
            data.delete_at(i)
            break
          end
        end
      end
    end
  end

  positions.permutation(2).map do |p1, p2|
    p1.zip(p2).map { |p1, p2| (p1 - p2).abs }.sum
  end.max
end

def input
  File.read(ARGV.first).split("\n\n").map do |scanner|
    scanner.split("\n").drop(1).map { |xyz| xyz.split(',').map(&:to_i) }
  end
end

puts process(input)
