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

    seeds.size.times do |i|
      maps.each do |map|
        map.each do |rule|
          if seeds[i] >= rule[1] && seeds[i] <= rule[1] + rule[2]
            break seeds[i] += rule[0] - rule[1]
          end
        end
      end
    end

    seeds.min
  end
end

puts Puzzle.new.solve