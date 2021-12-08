def process(data)
  data.sum do |d|
    chars_map = d[0].map { |dg| dg.chars.sort }

    mapped_digits = {}

    mapped_digits[chars_map.delete(chars_map.find { |c| c.size == 2 })] = 1
    mapped_digits[chars_map.delete(chars_map.find { |c| c.size == 3 })] = 7
    mapped_digits[chars_map.delete(chars_map.find { |c| c.size == 4 })] = 4
    mapped_digits[chars_map.delete(chars_map.find { |c| c.size == 7 })] = 8
    mapped_digits[chars_map.delete(chars_map.find { |c| c.size == 6 && (mapped_digits.key(4) - c).empty? })] = 9
    mapped_digits[chars_map.delete(chars_map.find { |c| c.size == 6 && (mapped_digits.key(7) - c).empty? })] = 0
    mapped_digits[chars_map.delete(chars_map.find { |c| c.size == 6 })] = 6
    mapped_digits[chars_map.delete(chars_map.find { |c| c.size == 5 && (mapped_digits.key(7) - c).empty? })] = 3
    mapped_digits[chars_map.delete(chars_map.find { |c| c.size == 5 && (c - mapped_digits.key(6)).empty? })] = 5
    mapped_digits[chars_map.delete(chars_map.find { |c| c.size == 5 })] = 2

    d[1].map { |dg| mapped_digits[dg.chars.sort] }.join.to_i
  end
end

def input
  File.readlines(ARGV.first).map do |l|
    l.chomp.split(' | ').map { |ll| ll.split(' ') }
  end
end

puts process(input)
