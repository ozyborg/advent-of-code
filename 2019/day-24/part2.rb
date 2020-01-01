def neighbours(l, y, x)
  res = []

  n_y, n_x = y - 1, x
  w_y, w_x = y, x - 1
  s_y, s_x = y + 1, x
  e_y, e_x = y, x + 1

  if n_y < 0
    res << [l - 1, 2 - 1, 2] if l > -100
  elsif n_y == 2 && n_x == 2
    5.times.each { |i| res << [l + 1, 4, i] } if l < 100
  else
    res << [l, n_y, n_x]
  end

  if w_x < 0
    res << [l - 1, 2, 2 - 1] if l > -100
  elsif w_y == 2 && w_x == 2
    5.times.each { |i| res << [l + 1, i, 4] } if l < 100
  else
    res << [l, w_y, w_x]
  end

  if s_y > 4
    res << [l - 1, 2 + 1, 2] if l > -100
  elsif s_y == 2 && s_x == 2
    5.times.each { |i| res << [l + 1, 0, i] } if l < 100
  else
    res << [l, s_y, s_x]
  end

  if e_x > 4
    res << [l - 1, 2, 2 + 1] if l > -100
  elsif e_y == 2 && e_x == 2
    5.times.each { |i| res << [l + 1, i, 0] } if l < 100
  else
    res << [l, e_y, e_x]
  end

  res
end

def hash_for(n)
  (n[0] + 100) * 10000 + n[1] * 100 + n[2]
end

def process(data)
  200.times do
    data = data.transform_values do |v|
      adj_count = v.last.map { |n| data[hash_for(n)].first }.count(1)
      new_v = case v.first
      when 1
        adj_count != 1 ? 0 : 1
      when 0
        adj_count == 1 || adj_count == 2 ? 1 : 0
      end
      [new_v, v.last]
    end
  end

  data.values.map(&:first).count(1)
end

def input
  hash = (-100..100).flat_map do |l|
    5.times.flat_map do |y|
      5.times.map do |x|
        [hash_for([l, y, x]), [0, neighbours(l, y, x)]] unless y == 2 && x == 2
      end.compact
    end
  end.to_h

  File.readlines('./input.txt').map.with_index do |line, y|
    line.strip.split('').each.with_index do |l, x|
      hash[hash_for([0, y, x])][0] = ['.', '#'].index(l) unless y == 2 && x == 2
    end
  end

  hash
end

puts process(input)
