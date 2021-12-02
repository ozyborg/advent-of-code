def process(data)
  seconds = 2503

  seqs = data.map do |d|
    Enumerator.new do |y|
      position = 0

      loop do
        d[2].times do
          position += d[1]
          y << position
        end

        d[3].times do
          y << position
        end
      end
    end
  end

  seqs.map { |s| s.take(seconds).last }.max
end

def input
  File.read(ARGV.first)
      .scan(/(\w+) can fly (\w+) km\/s for (\w+) seconds, but then must rest for (\w+) seconds.\n/)
      .map { |d| [d[0], d[1].to_i, d[2].to_i, d[3].to_i] }
end

puts process(input)

