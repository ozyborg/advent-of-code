def process(data)
  data = data.drop(input[0..6].join.to_i)
  phase = 100
  100.times do
    (data.size - 2).downto(0).each do |i|
      data[i] = (data[i] + data[i + 1]) % 10
    end
  end
  data[0..7].join
end

def input
  File.read('./input.txt').split('').map(&:to_i) * 10000
end

puts process(input)
