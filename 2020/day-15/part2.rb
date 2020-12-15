def process(data)
  positions = data.map.with_index { |d, i| [d, [nil, i]] }.to_h

  spoken = data.last

  (data.size..(30000000 - 1)).each do |d|
    if positions[spoken].first
      spoken = positions[spoken].last - positions[spoken].first
    else
      spoken = 0
    end
    positions[spoken] = [positions[spoken]&.last, d]
  end

  spoken
end

def input
  File.read('./input.txt').split(',').map(&:to_i)
end

puts process(input)
