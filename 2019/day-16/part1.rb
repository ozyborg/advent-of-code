def process(data)
  base_pattern = [[0], [1], [0], [-1]]
  100.times do
    (1..data.size).each do |i|
      pattern = base_pattern.flat_map { |e| e * i }.cycle
      data[i - 1] = ([0] + data).zip(pattern).inject(0) do |sum, arr|
        sum + arr.reduce(:*)
      end.abs % 10
    end
  end
  data[0..7].join
end

def input
  File.read('./input.txt').split('').map(&:to_i)
end

puts process(input)
