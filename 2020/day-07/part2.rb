def bag_count(data, current_bag)
  bags = data[current_bag]

  return 1 if bags.empty?

  1 + bags.inject(0) do |sum, b|
    sum + b[0].to_i * bag_count(data, b[1])
  end
end

def process(data)
  bag_count(data, 'shiny gold') - 1
end

def input
  File.readlines('./input.txt').map do |line|
    line.scan(/(.*) bags contain (.*)./).flatten
  end.to_h.transform_values do |v|
    v.scan(/(\d+) (.+?) bags?/).flatten(0)
  end
end

puts process(input)
