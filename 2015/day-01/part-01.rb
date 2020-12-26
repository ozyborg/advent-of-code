def process(data)
  data.count('(') - data.count(')')
end

def input
  File.read(ARGV.first).chomp.chars
end

puts process input

