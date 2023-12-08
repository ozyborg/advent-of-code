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

    network.each_slice(3) do |k, l, r|
      map[k + 'L'] = l
      map[k + 'R'] = r
    end

    current = 'AAA'
    steps = 0

    instructions.chars.cycle.each do |ins|
      current = map[current + ins]

      steps += 1

      break steps if current == 'ZZZ'
    end
  end
end

puts Puzzle.new.solve