def process(data)
  n_preamble = 25

  data.each_cons(n_preamble + 1) do |arr|
    *preamble, n = arr
    return n if preamble.combination(2).none? { |pair| pair.sum == n }
  end
end

def input
  File.readlines('./input.txt').map(&:to_i)
end

puts process(input)
