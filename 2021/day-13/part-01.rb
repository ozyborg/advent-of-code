def process(data)
  xys, rules = data

  dir, l = rules.first

  xys.map! { |x, y| x > l ? [l * 2 - x, y] : [x, y] }.uniq! if dir == 'x'
  xys.map! { |x, y| y > l ? [x, l * 2 - y] : [x, y] }.uniq! if dir == 'y'

  xys.size
end

def input
  xys, rules = File.read(ARGV.first).split("\n\n").map { |l| l.split("\n") }

  [
    xys.map { |xy| xy.split(',').map(&:to_i) },
    rules.map { |r| r.split(' ').last.split('=') }.map { |r| [r[0], r[1].to_i] }
  ]
end

puts process(input)
