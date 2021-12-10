def process(data)
  char_map = {
    '(' => ')',
    '[' => ']',
    '{' => '}',
    '<' => '>'
  }

  score_map = {
    ')' => '1',
    ']' => '2',
    '}' => '3',
    '>' => '4'
  }

  scores = data.map do |d|
    stack = []

    corrupted = false

    d.each do |c|
      if char_map[c]
        stack.push(c)
      else
        if char_map[stack.last] == c
          stack.pop
        else
          break corrupted = true
        end
      end
    end

    next if corrupted

    stack.reverse.map { |c| score_map[char_map[c]] }.join.to_i(5)
  end.compact

  scores.sort[scores.size / 2]
end

def input
  File.readlines(ARGV.first).map { |l| l.chomp.chars }
end

puts process(input)
