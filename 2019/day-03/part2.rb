def construct_path(steps)
  x = 0
  y = 0

  steps.flat_map do |step|
    step.last.times.map do
      case step.first
      when 'R'
        [x, y += 1]
      when 'L'
        [x, y -= 1]
      when 'U'
        [x += 1, y]
      when 'D'
        [x -= 1, y]
      end
    end
  end
end

def process(data)
  path1 = construct_path(data.first)
  path2 = construct_path(data.last)

  crosspoints = path1 & path2
  crosspoints.map { |p| path1.index(p) + 1 + path2.index(p) + 1 }.min
end

def input
  File.readlines('./input.txt').map do |line|
    line.split(',').map do |step|
      [step[0,1], step[1..-1].to_i]
    end
  end
end

puts process(input)
