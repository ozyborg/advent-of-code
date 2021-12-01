def process(data)
  data.each_cons(3).map(&:sum).each_cons(2).count { |d1, d2| d2 > d1 }
end

def input
  File.readlines(ARGV.first).map(&:to_i)
end

puts process(input)

