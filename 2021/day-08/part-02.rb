def process(data)
  digits = ['abcefg', 'cf', 'acdeg', 'acdfg', 'bcdf', 'abdfg', 'abdefg', 'acf', 'abcdefg', 'abcdfg']

  by_occurence = digits.flat_map(&:chars).tally
  by_size = digits.map(&:size)

  data.sum do |d|
    by_occurence_sub = d[0].flat_map(&:chars).tally
    by_size_sub = d[0].map { |x| [x.chars, x.size] }

    mapping = {}
    mapping['f'] = by_size_sub.find { |k, v| v == 2 }[0].find { |v| v == by_occurence_sub.find { |k, v| v == 9 }[0] }
    mapping['c'] = (by_size_sub.find { |k, v| v == 2 }[0] - [mapping['f']])[0]
    mapping['a'] = (by_size_sub.find { |k, v| v == 3 }[0] - [mapping['f'], mapping['c']])[0]
    mapping['e'] = by_occurence_sub.find { |k, v| v == 4 }[0]
    mapping['b'] = by_occurence_sub.find { |k, v| v == 6 }[0]
    mapping['d'] = (by_size_sub.find { |k, v| v == 4 }[0] - [mapping['b'], mapping['c'], mapping['f']])[0]
    mapping['g'] = (digits[8].chars - mapping.values)[0]
    mapping = mapping.invert

    d[1].map { |dg| digits.index(dg.chars.map { |c| mapping[c] }.sort.join) }.join.to_i
  end
end

def input
  File.readlines(ARGV.first).map do |l|
    l.chomp.split(' | ').map { |ll| ll.split(' ') }
  end
end

puts process(input)
