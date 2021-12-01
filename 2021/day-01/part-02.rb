def process(data)
  data.each_cons(3).map { |d| d.sum }.each_cons(2).count { |d| (d[1] - d[0]).positive? }
end

def input
  File.readlines(ARGV.first).map(&:to_i)
end

puts process(input)

