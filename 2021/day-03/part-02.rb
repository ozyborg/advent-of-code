def process(data)
  copy = data.dup

  data.first.size.times do |i|
    bits = copy.map { |c| c[i] }
    count = bits.tally
    most_common = count.values.first == count.values.last ? '1' : count.max_by(&:last).first
    copy = copy.filter { |c| c[i] == most_common }
    break if copy.one?
  end

  o_r = copy.join.to_i(2)

  copy = data.dup

  data.first.size.times do |i|
    bits = copy.map { |c| c[i] }
    count = bits.tally
    least_common = count.values.first == count.values.last ? '0' : count.min_by(&:last).first
    copy = copy.filter { |c| c[i] == least_common }
    break if copy.one?
  end

  co_r = copy.join.to_i(2)

  o_r * co_r
end

def input
  File.readlines(ARGV.first).map { |l| l.chomp.chars }
end

puts process(input)
