def score
  {
    "A X" => 4,
    "A Y" => 8,
    "A Z" => 3,
    "B X" => 1,
    "B Y" => 5,
    "B Z" => 9,
    "C X" => 7,
    "C Y" => 2,
    "C Z" => 6,
  }
end

def score_mapper
  {
    "A X" => "A Z",
    "A Y" => "A X",
    "A Z" => "A Y",
    "B X" => "B X",
    "B Y" => "B Y",
    "B Z" => "B Z",
    "C X" => "C Y",
    "C Y" => "C Z",
    "C Z" => "C X"
  }
end

def part_2(data)
  data.sum { |d| score[score_mapper[d]] }
end

def part_1(data)
  data.sum { |d| score[d] }
end

def input
  File.read(ARGV.first).split("\n")
end

puts part_1(input)
puts part_2(input)
