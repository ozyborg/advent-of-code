def process(data)
  (data.first..data.last).count do |i|
    monotonic = true
    unique_pair = {}

    4.downto(0) do |j|
      pair = (i / (10 ** j)) % 100
      unique_pair[pair] = !unique_pair.key?(pair) if pair % 11 == 0
      monotonic = (pair % 10) >= (pair / 10)
      break unless monotonic
    end

    monotonic && unique_pair.values.any?
  end
end

def input
  File.read('./input.txt').split('-').map(&:to_i)
end

puts process(input)
