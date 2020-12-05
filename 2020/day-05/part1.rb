def process(data)
  char_vals = {
    'F' => '0',
    'B' => '1',
    'L' => '0',
    'R' => '1'
  }

  data.map { |d| d.split('').map { |c| char_vals[c] }.join('').to_i(2) }.max
end

def input
  File.readlines('./input.txt')
end

puts process(input)
