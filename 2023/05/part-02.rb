class Puzzle
  def input
    @input ||= File.read('./input.txt')
  end

  def data
    @data ||= input.split("\n\n").map do |group|
      arr = group.split("\n")

      if arr.size == 1
        arr.first.split(': ').last.split.map(&:to_i)
      else
        arr[1..-1].map { |l| l.split.map(&:to_i) }
      end
    end
  end

  def solve
    seeds, *maps = data

    ranges = seeds.each_slice(2).map { |start, length| [start, start + length] }

    maps.each do |map|
      next_ranges = []

      until ranges.empty?
        range = ranges.shift

        rule = map.find { |rule| range[0] < rule[1] + rule[2] && rule[1] < range[1] }

        if rule
          lower_bound = [range[0], rule[1]].max
          upper_bound = [range[1], rule[1] + rule[2]].min

          d = rule[0] - rule[1]

          next_ranges << [lower_bound + d, upper_bound + d]
          ranges << [range[0], lower_bound] if lower_bound > range[0]
          ranges << [upper_bound, range[1]] if upper_bound < range[1]
        else
          next_ranges << range
        end
      end
      ranges = next_ranges
    end

    ranges.map(&:first).min
  end
end

puts Puzzle.new.solve