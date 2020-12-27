def process(data)
  cities = data.keys.flatten.uniq
  cities.permutation.map do |path|
    path.each_cons(2).inject(0) do |sum, pair|
      sum + data[pair.sort]
    end
  end.min
end

def input
  File.read(ARGV.first).scan(/(\w+) to (\w+) = (\d+)/).map do |line|
    [line.first(2).sort, line.last.to_i]
  end.to_h
end

puts process(input)

