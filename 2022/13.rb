def compare(a, b)
  return a <=> b if a.is_a?(Integer) && b.is_a?(Integer)

  a = [a] if a.is_a?(Integer)
  b = [b] if b.is_a?(Integer)

  [a.size, b.size].min.times do |i|
    compare(a[i], b[i]).tap { |cmp| return cmp if cmp != 0 }
  end

  a.length <=> b.length
end

def part_2(data)
  data << [[2]]
  data << [[6]]

  data.sort! { |a, b| compare(a, b) }

  (data.index([[2]]) + 1) * (data.index([[6]]) + 1)
end

def part_1(data)
  data.each_slice(2).map.with_index do |(a, b), i|
    compare(a, b) < 0 ? i + 1 : 0
  end.sum
end

def input
  File.read('./inputs/13.txt').split("\n").map { |d| eval(d) }.compact
end

puts part_1(input)
puts part_2(input)
