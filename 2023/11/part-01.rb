class Puzzle
  def input
    @input ||= File.read('./input.txt')
  end

  def data
    @data ||= input.split("\n").map(&:chars)
  end

  def solve
    empty_rows = data.filter_map.with_index { |row, i| i if row.all?('.') }
    empty_cols = data.transpose.filter_map.with_index { |col, i| i if col.all?('.') }

    galaxies = []

    data.each.with_index do |row, i|
      row.each.with_index do |col, j|
        if col == '#'
          galaxies << [
            i + empty_rows.count { |r| r < i },
            j + empty_cols.count { |c| c < j }
          ]
        end
      end
    end

    galaxies.combination(2).sum do |g1, g2|
      (g1[0] - g2[0]).abs + (g1[1] - g2[1]).abs
    end
  end
end

puts Puzzle.new.solve