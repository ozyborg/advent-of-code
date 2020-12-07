def contains_bag?(data, current_bag, search_bag)
  bags = data[current_bag]

  return false if bags.empty?

  return true if bags.include?(search_bag)

  bags.any? do |b|
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
    line.scan(/(.*) bags contain (.*)./).flatten
  end.to_h.transform_values do |v|
    v.scan(/\d+ (.+?) bags?/).flatten
  end
end

puts process(input)
