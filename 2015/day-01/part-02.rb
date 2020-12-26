def process(data)
  char_map = { '(' => 1, ')' => -1 }

  data.each_with_index.inject(0) do |floor, (d, i)|
    break i if floor < 0

    floor + char_map[d]
  end
end

def input
  File.read(ARGV.first).chomp.chars
end

puts process(input)

