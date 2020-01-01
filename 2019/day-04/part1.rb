def process(data)
  (data.first..data.last).count do |i|
    monotonic = true
    has_pair = false

    4.downto(0) do |j|
      pair = (i / (10 ** j)) % 100
      has_pair = pair % 11 == 0 unless has_pair
      monotonic = (pair % 10) >= (pair / 10)
      break unless monotonic
    end

    monotonic && has_pair
  end
end

def input
  File.read('./input.txt').split('-').map(&:to_i)
end

puts process(input)
