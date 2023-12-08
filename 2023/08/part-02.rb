class Puzzle
  def input
    @input ||= File.read('./input.txt')
  end

  def data
    @data ||= input.scan(/[A-Z]*/).reject(&:empty?)
  end

  def solve
    instructions, *network = data

    map = {}
    points = []

    network.each_slice(3) do |k, l, r|
      map[k + 'L'] = l
      map[k + 'R'] = r

      points << k if k.end_with?('A')
    end

    points.map do |current|
      steps = 0

      instructions.chars.cycle.each do |ins|
        current = map[current + ins]

        steps += 1

        break steps if current.end_with?('Z')
      end
    end.reduce(&:lcm)
  end
end

puts Puzzle.new.solve