def print_code(xys)
  (0..xys.map(&:last).max).map do |y|
    (0..xys.map(&:first).max).map do |x|
      xys.include?([x, y]) ? '#' : '.'
    end.join
  end.join("\n")
end

def process(data)
  xys, rules = data

  rules.each do |r|
    dir, l = r

    xys.map! { |x, y| x > l ? [l * 2 - x, y] : [x, y] }.uniq! if dir == 'x'
    xys.map! { |x, y| y > l ? [x, l * 2 - y] : [x, y] }.uniq! if dir == 'y'
  end

  print_code(xys)
end

def input
  xys, rules = File.read(ARGV.first).split("\n\n").map { |l| l.split("\n") }

  [
    xys.map { |xy| xy.split(',').map(&:to_i) },
    rules.map { |r| r.split(' ').last.split('=') }.map { |r| [r[0], r[1].to_i] }
  ]
end

puts process(input)
