def process(data)
  expression_rule = /\(([^()]+)\)/
  plus_rule = /\d+ [+] \d+/
  star_rule = /\d+ [*] \d+/

  data.inject(0) do |sum, expression|
    sum + loop do
      e = expression.match(expression_rule).to_s

      break expression.to_i if e.empty?

      result = e.dup

      [plus_rule, star_rule].each do |rule|
        loop do
          exp = result.match(rule).to_s

          break if exp.empty?

          result.sub!(exp, eval(exp).to_s)
        end
      end

      expression.sub!(e, eval(result).to_s)
    end
  end
end

def input
  File.readlines('./input.txt').map { |exp| "(#{exp})" }
end

puts process(input)
