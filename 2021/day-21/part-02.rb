$history = {}

def count(positions, scores, i = 0)
  [1, 2, 3].repeated_permutation(3).map do |perm|
    p_copy = positions.dup
    s_copy = scores.dup
    p_copy[i % 2] = (p_copy[i % 2] + perm.sum) % 10
    s_copy[i % 2] += p_copy[i % 2] + 1
    next [1, 0] if s_copy[0] >= 21
    next [0, 1] if s_copy[1] >= 21
    $history[[p_copy, s_copy, i % 2]] ||= count(p_copy, s_copy, i + 1)
  end.transpose.map(&:sum)
end

def process(data)
  count([data[0] - 1, data[1] - 1], [0, 0], 0).max
end

def input
  File.readlines(ARGV.first).map { |l| l.chomp.chars.last.to_i }
end

puts process(input)
