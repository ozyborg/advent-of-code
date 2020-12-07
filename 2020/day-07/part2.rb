def bag_count(data, current_bag)
  bags = data[current_bag].split(/(\d+) (.+?) bags?/)

  return 1 if bags.size == 1

  1 + (bags.size / 3).times.inject(0) do |sum, i|
    sum + (bags[(i * 3) + 1].to_i * bag_count(data, bags[(i * 3) + 2]))
  end
end

def process(data)
  bag_count(data, 'shiny gold') - 1
end

def input
  File.readlines('./input.txt').map do |line|
    line.match(/(.*) bags contain (.*)./).to_a[1..-1]
  end.to_h
end

puts process(input)
