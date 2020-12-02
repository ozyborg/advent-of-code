def process(data)
  data.count do |d|
    char_count = d[:password].count(d[:char])

    char_count >= d[:min].to_i && char_count <= d[:max].to_i
  end
end

def input
  File.readlines('./input.txt').map do |line|
    line.match(/(?<min>\d{1,2})-(?<max>\d{1,2}) (?<char>\w{1}): (?<password>.*)/)
  end
end

puts process(input)
