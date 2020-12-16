def process(data)
  rules = data[0].split("\n").map do |d|
    rule = d.match(/(.*): (\d+)-(\d+) or (\d+)-(\d+)/).captures

    {
      field: rule[0],
      sets: [
        { min: rule[1].to_i, max: rule[2].to_i },
        { min: rule[3].to_i, max: rule[4].to_i }
      ]
    }
  end

  nearby_tickets = data[2].split("\n")[1..-1].map { |t| t.split(',').map(&:to_i) }
  nearby_tickets.flatten.select do |v|
    rules.none? do |rule|
      rule[:sets].any? { |s| v >= s[:min] && v <= s[:max] }
    end
  end.sum
end

def input
  File.read('./input.txt').split("\n\n")
end

puts process(input)
