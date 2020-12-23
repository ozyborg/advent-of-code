def process(data)
  max = 1000000
  loop_count = 10000000

  data = data + (10..max).to_a

  nexts = data.each_cons(2).to_a.to_h
  nexts[data.last] = data.first

  first = data.first

  loop_count.times do
    pick_up = []
    pick_up << nexts[first]
    pick_up << nexts[pick_up.last]
    pick_up << nexts[pick_up.last]

    dest = first - 1
    loop do
      dest = max if dest == 0
      if pick_up.include?(dest)
        dest -= 1
      else
        break
      end
    end

    nexts[first] = nexts[pick_up.last]
    first = nexts[pick_up.last]
    nexts[pick_up.last] = nexts[dest]
    nexts[dest] = pick_up.first
  end

  nexts[1] * nexts[nexts[1]]
end

def input
  File.read('./input.txt').chars.map(&:to_i)
end

puts process(input)
