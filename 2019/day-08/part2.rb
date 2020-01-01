def print_image(data)
  char_map = [' ', '*']
  data.map do |d|
    d.map do |p|
      char_map[p]
    end.join
  end.join("\n")
end

def pixel_for_stack(stack)
  stack.reject { |p| p == 2 }.first
end

def construct_image(data, w, h)
  data.each_slice(w * h).map { |i| i.each_slice(w).to_a }
end

def process(data)
  print_image(
    construct_image(data, 25, 6)
    .transpose
    .map do |rows|
      rows.transpose.map do |column|
        pixel_for_stack(column)
      end
    end
  )
end

def input
  File.read('./input.txt').split('').map(&:to_i)
end

puts process(input)
