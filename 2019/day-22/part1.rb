def process(data)
  size = 10007
  deck = (0..size - 1).to_a

  data.each do |technique, n|
    case technique
    when 'deal into new stack'
      deck.reverse!
    when 'cut'
      deck.rotate!(n.to_i)
    when 'deal with increment'
      tmp_deck = Array.new(size)
      size.times { |i| tmp_deck[n.to_i * i % size] = deck[i] }
      deck = tmp_deck
    end
  end

  deck.index(2019)
end

def input
  File.readlines('./input.txt').map do |line|
    if line.include?('new stack')
      [line.strip]
    else
      line.strip.rpartition(' ') - [' ']
    end
  end
end

puts process(input)
