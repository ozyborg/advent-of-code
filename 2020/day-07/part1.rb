def contains_bag?(data, current_bag, search_bag)
  bags = data[current_bag].split(/(\d+) (.+?) bags?/)

  return false if bags.size == 1
  return true if data[current_bag].include?(search_bag)

  bags.select.with_index{ |b, i| (i + 1) % 3 == 0 }.any? do |b|
    contains_bag?(data, b, search_bag)
  end
end

def process(data)
  data.count do |k, v|
    contains_bag?(data, k, 'shiny gold')
  end
end

def input
  File.readlines('./input.txt').map do |line|
    line.match(/(.*) bags contain (.*)./).to_a[1..-1]
  end.to_h
end

puts process(input)
