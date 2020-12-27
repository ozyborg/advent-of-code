def process(data)
  cities = data.keys.flatten.uniq
  cities.permutation.map do |path|
    path.each_cons(2).inject(0) do |sum, pair|
      sum + data[pair.sort]
    end
  end.max
end

def input
  File.read(ARGV.first).scan(/(\w+) to (\w+) = (\d+)/).map do |line|
    [line.first(2).sort, line[2].to_i]
  end.to_h
end

puts process(input)

