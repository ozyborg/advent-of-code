def priority(item)
  (('a'..'z').to_a + ('A'..'Z').to_a).index(item) + 1
end

def part_2(data)
  data.each_slice(3).sum do |dd|
    priority(dd.reduce(:&).first)
  end
end

def part_1(data)
  data.sum do |d|
    priority(d.each_slice(d.size / 2).reduce(:&).first)
  end
end

def input
  File.read('./inputs/03.txt').split("\n").map(&:chars)
end

puts part_1(input)
puts part_2(input)
