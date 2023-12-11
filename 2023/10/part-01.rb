class Puzzle
  def input
    @input ||= File.read('./input.txt')
  end

  def data
    @data ||= input.split("\n").flat_map.with_index do |l, y|
      l.chars.map.with_index { |v, x| [[x, y], v] }
    end.to_h
  end

  def pipes
    @pipes ||= {
      '|' => [[0, -1], [0, 1]],
      '-' => [[1, 0], [-1, 0]],
      'L' => [[0, -1], [1, 0]],
      'J' => [[0, -1], [-1, 0]],
      '7' => [[0, 1], [-1, 0]],
      'F' => [[0, 1], [1, 0]],
    }
  end

  def solve
    s = data.key('S')

    adj_map = {}

    data.select { |k, v| pipes.include?(v) }.each do |k, v|
      adj_map[k] = pipes[v].map do |delta|
        k.zip(delta).map(&:sum)
      end
    end

    adj_map[s] = adj_map.select { |k, v| v.include?(s) }.keys

    queue = [s]
    depth = 0
    visited = {}

    until queue.empty?
      current = queue.shift

      next if visited[current]

      visited[current] = true

      queue += adj_map[current]

      depth += 1
    end

    depth / 2
  end
end

puts Puzzle.new.solve