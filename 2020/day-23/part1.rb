def process(data)
  100.times do
    current, *pick_up = data.first(4)

    dest = current - 1
    loop do
      dest = 9 if dest == 0
      if pick_up.include?(dest)
        dest -= 1
      else
        break
      end
    end
    dest_pos = data.index(dest)

    data = data[4..dest_pos-1] + [dest] + pick_up + data[dest_pos+1..-1] + [current]
  end

  until data.first == 1 do
    data.rotate!
  end
  data.drop(1).join
end

def input
  File.read('./input.txt').chars.map(&:to_i)
end

puts process(input)
