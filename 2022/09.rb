def step(state, dir)
  case dir
  when 'R'
    state[0][1] += 1
  when 'U'
    state[0][0] -= 1
  when 'L'
    state[0][1] -= 1
  when 'D'
    state[0][0] += 1
  end

  (1..state.size - 1).each do |i|
    d_0 = state[i - 1][0] - state[i][0]
    d_1 = state[i - 1][1] - state[i][1]

    if d_0.abs > 1 || d_1.abs > 1
      if d_0 == 0
        state[i][1] += d_1 / 2
      elsif d_1 == 0
        state[i][0] += d_0 / 2
      else
        state[i][0] += d_0 <=> 0
        state[i][1] += d_1 <=> 0
      end
    end
  end
end

def part_2(data)
  state = Array.new(10) { [0, 0] }

  tails = {}

  data.each do |dir, step|
    step.to_i.times do
      step(state, dir)

      tails[state.last] = true
    end
  end

  tails.size
end

def part_1(data)
  state = Array.new(2) { [0, 0] }

  tails = {}

  data.each do |dir, step|
    step.to_i.times do
      step(state, dir)

      tails[state.last] = true
    end
  end

  tails.size
end

def input
  File.read('./inputs/09.txt').scan(/([RULD]) (\d+)\n?/)
end

puts part_1(input)
puts part_2(input)
