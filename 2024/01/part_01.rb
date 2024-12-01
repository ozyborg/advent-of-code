def input
  File.read(ARGV[0] || './input.txt')
end

def data
  input.split("\n")
    .map { |line| line.split(' ').map(&:to_i) }
    .transpose
end

def result(data)
  data.map(&:sort).transpose.sum { |d| (d[0] - d[1]).abs }
end

puts result(data)