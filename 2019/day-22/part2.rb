def process(data)
  size = 119315717514047
  value = 2020
  count = 101741582076661

  a = 1
  b = 0

  data.reverse.each do |technique, n|
    case technique
    when 'deal into new stack'
      b += 1
      a *= -1
      b *= -1
    when 'cut'
      b += n.to_i
    when 'deal with increment'
      p = n.to_i.pow(size - 2, size)
      a *= p
      b *= p
    end
    a %= size
    b %= size
  end

  (a.pow(count, size) * value + b * (a.pow(count, size) + size - 1) * ((a - 1).pow(size - 2, size))) % size
end

def input
  File.readlines('./input.txt').map do |line|
    if line.include?('new stack')
      [line.strip]
    else
      line.strip.rpartition(' ') - [' ']
    end
  end
end

puts process(input)
