def process(data)
  card_pk, door_pk = data

  n = 1
  loop_size = (1..).each do |i|
    n *= 7
    n %= 20201227
    break i if n == card_pk
  end

  loop_size.times.inject(1) do |k|
    k *= door_pk
    k %= 20201227
  end
end

def input
  File.readlines('./input.txt').map(&:to_i)
end

puts process(input)
