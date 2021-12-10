def process(data)
  char_map = {
    '(' => ')',
    '[' => ']',
    '{' => '}',
    '<' => '>'
  }

  score_map = {
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137
  }

  data.sum do |d|
    stack = []
    score = 0

    d.each do |c|
      if char_map[c]
        stack.push(c)
      else
        if char_map[stack.last] == c
          stack.pop
        else
          score += score_map[c]
          break
        end
      end
    end

    score
  end
end

def input
  File.readlines(ARGV.first).map { |l| l.chomp.chars }
end

puts process(input)
