def part_2(data)
  data.each_cons(14).with_index do |cons, i|
    break i + 14 if cons.uniq.length == 14
  end
end

def part_1(data)
  data.each_cons(4).with_index do |cons, i|
    break i + 4 if cons.uniq.length == 4
  end
end

def input
  File.read('./inputs/06.txt').chars
end

puts part_1(input)
puts part_2(input)
