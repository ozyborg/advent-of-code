def score
  {
    "A X" => 3,
    "A Y" => 6,
    "A Z" => 0,
    "B X" => 0,
    "B Y" => 3,
    "B Z" => 6,
    "C X" => 6,
    "C Y" => 0,
    "C Z" => 3,
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

def value
  {
    "X" => 1,
    "Y" => 2,
    "Z" => 3
  }
end

def part_2(data)
  data.map { |d| score[score_mapper[d]] + value[score_mapper[d][-1]] }.sum
end

def part_1(data)
  data.map { |d| score[d] + value[d[-1]] }.sum
end

def input
  File.read(ARGV.first).split("\n")
end

puts part_1(input)
puts part_2(input)
