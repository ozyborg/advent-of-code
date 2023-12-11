class Puzzle
  def input
    @input ||= File.read('./input.txt')
  end

  def data
    @data ||= input.split("\n").flat_map.with_index do |l, y|
      l.chars.map.with_index { |v, x| [[x, y], v] }
    end.to_h
  end

  def contains?(points, point)
    last_point = points[-1]
    oddNodes = false
    x, y = point

    points.each do |pt|
      xi, yi = pt
      xj, yj = last_point

      if yi < y && yj >= y || yj < y && yi >= y
        oddNodes = !oddNodes if xi + (y - yi) / (yj - yi) * (xj - xi) < x
      end

      last_point = pt
    end

    oddNodes
  end

  def solve
    s = data.key('S')

    vector = nil
    vector = [1, 0] if ['-', '7', 'J'].include?(data[[s[0] + 1, s[1]]])
    vector = [0, 1] if vector.nil?

    points = [s]

    loop do
      current = points.last

      case data[current]
      when '7'
        vector = [0, 1] if vector == [1, 0]
        vector = [-1, 0] if vector == [0, -1]
      when 'J'
        vector = [-1, 0] if vector == [0, 1]
        vector = [0, -1] if vector == [1, 0]
      when 'L'
        vector = [1, 0] if vector == [0, 1]
        vector = [0, -1] if vector == [-1, 0]
      when 'F'
        vector = [1, 0] if vector == [0, -1]
        vector = [0, 1] if vector == [-1, 0]
      end

      points << current.zip(vector).map(&:sum)

      break if points.last == s
    end

    data.count { |k, v| !points.include?(k) && contains?(points, k) }
  end
end

puts Puzzle.new.solve