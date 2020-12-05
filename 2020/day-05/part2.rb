def process(data)
  char_vals = {
    'F' => '0',
    'B' => '1',
    'L' => '0',
    'R' => '1'
  }

  seat_ids = data.map { |d| d.split('').map { |c| char_vals[c] }.join('').to_i(2) }.sort

  seat_ids.find.with_index { |id, i| seat_ids[i + 1] != id + 1 } + 1
end

def input
  File.readlines('./input.txt')
end

puts process(input)
