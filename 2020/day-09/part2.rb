def process(data)
  n = 552655238

  p = 0
  cons = 2

  loop do
    ns = data[p..p+cons]

    break ns.min + ns.max if ns.sum == n

    if ns.sum > n
      cons = 2
      p += 1
    else
      cons += 1
    end
  end
end

def input
  File.readlines('./input.txt').map(&:to_i)
end

puts process(input)
