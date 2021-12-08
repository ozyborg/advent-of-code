def process(data)
  data.flat_map(&:last).count { |d| [2, 4, 3, 7].include?(d.length) }
end

def input
  File.readlines(ARGV.first).map do |l|
    l.chomp.split(' | ').map { |ll| ll.split(' ') }
  end
end

puts process(input)
