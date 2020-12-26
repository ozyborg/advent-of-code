def process(data)
  data.count do |d|
    d.match(/([a-z][a-z])[a-z]*\1/) &&
    d.match(/([a-z])[a-z]\1/)
  end
end

def input
  File.readlines(ARGV.first)
end

puts process(input)

