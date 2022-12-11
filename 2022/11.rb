def part_2(data)
  inspects = [0] * data.size

  lcm = data.map { |d| d[2] }.reduce(&:lcm)

  10000.times do
    data.each.with_index do |d, i|
      items, op, div, if_t, if_f = d

      items.each do |item|
        item = eval(op.gsub('old', item))
        item %= lcm
        data[item % div == 0 ? if_t : if_f][0] << item.to_s
      end

      inspects[i] += items.size
      items.clear
    end
  end

  inspects.sort.last(2).reduce(:*)
end

def part_1(data)
  inspects = [0] * data.size

  20.times do
    data.each.with_index do |d, i|
      items, op, div, if_t, if_f = d

      items.each do |item|
        item = eval(op.gsub('old', item))
        item /= 3
        data[item % div == 0 ? if_t : if_f][0] << item.to_s
      end

      inspects[i] += items.size
      items.clear
    end
  end

  inspects.sort.last(2).reduce(:*)
end

def input
  File.read('./inputs/11.txt').split("\n\n").map do |l|
    i, items, op, div, if_t, if_f = l.split("\n")

    [
      items.scan(/\d+/),
      op.split(' = ').last,
      div.scan(/\d+/).first.to_i,
      if_t.scan(/\d+/).first.to_i,
      if_f.scan(/\d+/).first.to_i
    ]
  end
end

puts part_1(input)
puts part_2(input)
