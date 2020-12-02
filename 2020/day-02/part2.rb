def process(data)
  data.count do |d|
    char_1 = d[:password][d[:p1].to_i - 1]
    char_2 = d[:password][d[:p2].to_i - 1]

    (char_1 == d[:char]) ^ (char_2 == d[:char])
  end
end

def input
  File.readlines('./input.txt').map do |line|
    line.match(/(?<p1>\d{1,2})-(?<p2>\d{1,2}) (?<char>\w{1}): (?<password>.*)/)
  end
end

puts process(input)
