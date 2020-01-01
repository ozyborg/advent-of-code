def process(data)
  history = {}

  loop do
    data = data.map.with_index do |xs, y|
      xs.map.with_index do |v, x|
        adj_count = [
          data.dig(y, x + 1),
          x > 0 ? data.dig(y, x - 1) : nil,
          data.dig(y + 1, x),
          y > 0 ? data.dig(y - 1, x) : nil
        ].count(1)

        if v == 1
          adj_count != 1 ? 0 : 1
        else
          adj_count == 1 || adj_count == 2 ? 1 : 0
        end
      end
    end

    value = data.flatten.reverse.join.to_i(2)
    break value if history.key?(value)
    history[value] = true
  end
end

def input
  File.readlines('./input.txt').map do |line|
    line.strip.split('').map { |l| ['.', '#'].index(l) }
  end
end

puts process(input)
