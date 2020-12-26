def process(data)
  data.count do |d|
    d.scan(/[aeiou]/).size >= 3 &&
    d.scan(/([a-z])\1/).size >= 1 &&
    d.scan(/ab|cd|pq|xy/).empty?
  end
end

def input
  File.readlines(ARGV.first)
end

puts process input

