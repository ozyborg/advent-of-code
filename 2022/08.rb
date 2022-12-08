DELTAS = [
  [-1, 0],
  [0, 1],
  [1, 0],
  [0, -1]
]

def part_2(data)
  data.map do |xy, v|
    DELTAS.inject(1) do |product, d|
      pos = xy.dup

      (1..).each do |i|
        pos = pos.zip(d).map(&:sum)

        break product * (i - 1) if data[pos].nil?
        break product * i if data[pos] >= v
      end
    end
  end.max
end

def part_1(data)
  data.count do |xy, v|
    DELTAS.any? do |d|
      pos = xy.dup

      loop do
        pos = pos.zip(d).map(&:sum)

        break true if data[pos].nil?
        break false if data[pos] >= v
      end
    end
  end
end

def input
  File.read('./inputs/08.txt').split("\n")
      .flat_map.with_index do |l, y|
        l.chars.map.with_index { |v, x| [[x, y], v.to_i] }
      end.to_h
end

puts part_1(input)
puts part_2(input)
