def consume(message, rules, top)
  sets = rules[top]

  result = message.dup

  sets.each do |set|
    if (%w("a" "b").include?(set[0]))
      return message.drop(1) if message[0] == set[0].chars[1]
    else
      last_result = result.dup

      set.each do |s|
        next_result = consume(result, rules, s)

        if result == next_result
          result = message.dup
          break
        else
          result = next_result
        end
      end

      break if last_result != result
    end
  end

  result
end

def process(data)
  rules, messages = data

  messages = messages.split("\n")

  rules = rules.split("\n").map do |r|
    n, rule = r.split(': ')

    paths = rule.split(' | ').map { |sub_rule| sub_rule.split(' ') }

    [n, paths]
  end.to_h

  # This trick does not work :(
  rules['8'] = (1..50).map { |i| ['42'] * i }.reverse
  rules['11'] = (1..50).map { |i| (['42'] * i) + (['31'] * i) }.reverse

  messages.count { |m| consume(m.chars, rules, '0').empty? }
end

def input
  File.read('./input.txt').split("\n\n")
end

puts process(input)
