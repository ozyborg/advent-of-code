def process(data)
  template, rules = data

  counts = rules.map { |k, v| [k.chars, 0] }.to_h
  e_counts = counts.keys.flatten.uniq.map { |e| [e, 0] }.to_h

  template.each_cons(2) { |c| counts[c] += 1 }
  template.each { |e| e_counts[e] += 1 }

  40.times do
    counts.dup.each do |k, v|
      counts[k] -= v
      counts[[k[0], rules[k.join]]] += v
      counts[[rules[k.join], k[1]]] += v
      e_counts[rules[k.join]] += v
    end
  end

  e_counts.values.max - e_counts.values.min
end

def input
  template, rules = File.read(ARGV.first).split("\n\n")

  [
    template.chars,
    rules.split("\n").map { |r| r.chomp.split(" -> ") }.to_h
  ]
end

puts process(input)
