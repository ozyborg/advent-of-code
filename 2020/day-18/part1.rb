def process(data)
  data.inject(0) do |sum, expression|
    sum + loop do
      e = expression.match(/(\d+|\(\d+\)) [*+] (\d+|\(\d+\))/).to_s

      break expression.to_i if e.empty?

      expression.sub!(e, eval(e).to_s)
    end
  end
end

def input
  File.readlines('./input.txt')
end

puts process(input)
