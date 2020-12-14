def process(data)
  mem = {}
  mask = ''

  data.each do |d|
    left, right = d.chomp.split(' = ')

    if left == 'mask'
      mask = right
    else
      pos = left.scan(/mem\[(\d+)\]/).flatten.first.to_i
      bin = right.to_i.to_s(2).chars

      (36 - bin.size).times do
        bin.unshift('0')
      end

      bin = bin.map.with_index do |b, i|
        case mask[i]
        when 'X'
          b
        else
          mask[i]
        end
      end

      mem[pos] = bin.join.to_i(2)
    end
  end

  mem.values.sum
end

def input
  File.readlines('./input.txt')
end

puts process(input)
