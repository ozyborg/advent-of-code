def input
  File.read(ARGV[0] || './input.txt')
end

def data
  input.split("\n")
    .map { |line| line.split(' ').map(&:to_i) }
    .transpose
end

def result(data)
  data[0].sum { |d| d * data[1].count(d) }
end

puts result(data)