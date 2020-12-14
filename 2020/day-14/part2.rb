def process(data)
  mem = {}
  mask = ''

  data.each do |d|
    left, right = d.chomp.split(' = ')
    if left == 'mask'
      mask = right
    else
      val = right.to_i
      pos = left.scan(/mem\[(\d+)\]/).flatten.first.to_i
      bin = pos.to_i.to_s(2).chars

      (36 - bin.size).times do
        bin.unshift('0')
      end

      bin = bin.map.with_index do |b, i|
        case mask[i]
        when '0'
          b
        else
          mask[i]
        end
      end

      %w[0 1].repeated_permutation(bin.count('X')) do |c|
        possible_pos = bin.map do |b|
          case b
          when 'X'
            c.shift
          else
            b
          end
        end
        mem[possible_pos.join.to_i(2)] = val
      end
    end
  end

  mem.values.sum
end

def input
  File.readlines('./input.txt')
end

puts process(input)
