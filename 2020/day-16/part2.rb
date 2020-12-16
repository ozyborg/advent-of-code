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

  ticket = data[1].split("\n")[1].split(',').map(&:to_i)

  nearby_tickets = data[2].split("\n")[1..-1].map { |t| t.split(',').map(&:to_i) }
  valid_tickets = nearby_tickets.reject do |t|
    t.any? do |v|
      rules.none? do |rule|
        rule[:sets].any? { |s| v >= s[:min] && v <= s[:max] }
      end
    end
  end

  fields = ([ticket] + valid_tickets).transpose.map do |values|
    rules.select do |rule|
      values.all? do |v|
        rule[:sets].any? { |s| v >= s[:min] && v <= s[:max] }
      end
    end.map { |r| r[:field] }
  end

  indexed_fields = fields.map.with_index { |f, i| [i, f] }.sort { |x, y| x[1].size <=> y[1].size }.to_h

  indexed_fields = indexed_fields.map do |k, v|
    indexed_fields.transform_values! { |vv| vv - v }
    [k, v.first]
  end

  departure_fields = indexed_fields.to_h.select { |k, v| v.include?('departure') }.keys

  ticket.select.with_index { |t, i| departure_fields.include?(i) }.reduce(:*)
end

def input
  File.read('./input.txt').split("\n\n")
end

puts process(input)
