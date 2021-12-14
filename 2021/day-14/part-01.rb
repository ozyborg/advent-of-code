def process(data)
  template, rules = data

  10.times do
    elements = template.each_cons(2).map { |c| rules[c.join] }
    template = template.zip(elements).flatten.compact
  end

  freq = template.tally.values

  freq.max - freq.min
end

def input
  template, rules = File.read(ARGV.first).split("\n\n")

  [
    template.chars,
    rules.split("\n").map { |r| r.chomp.split(" -> ") }.to_h
  ]
end

puts process(input)
