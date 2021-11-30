def process(data)
  loop do
    data = data.next

    next if data.include? 'i'
    next if data.include? 'o'
    next if data.include? 'l'

    chars = data.chars

    next if chars.each_cons(3).none? { |c| c[0].next == c[1] && c[1].next == c[2] }

    next if chars.each_cons(2).filter { |c| c[1] == c[0] }.uniq.size <= 1

    break data
  end
end

def input
  File.read(ARGV.first).chomp
end

puts process(input)

