def compare(a, b)
  if a.is_a?(Integer) && b.is_a?(Integer)
    a <=> b
  elsif a.is_a?(Array) && b.is_a?(Array)
    a.zip(b).each do |ab|
      next if ab.include?(nil)
      cmp = compare(*ab)
      return cmp if cmp != 0
    end

    a.length <=> b.length
  else
    compare([a].flatten(1), [b].flatten(1))
  end
end

def part_2(data)
  data = data.split("\n").map { |d| eval(d) }.compact

  data << [[2]]
  data << [[6]]

  data.sort! { |a, b| compare(a, b) }

  (data.index([[2]]) + 1) * (data.index([[6]]) + 1)
end

def part_1(data)
  data = data.split("\n\n").map do |ab|
    a, b = ab.split("\n")

    [eval(a), eval(b)]
  end

  data.map.with_index do |ab, i|
    compare(*ab) == -1 ? i + 1 : 0
  end.sum
end

def input
  File.read('./inputs/13.txt')
end

puts part_1(input)
puts part_2(input)
