def construct_image(data, w, h)
  data.each_slice(w * h).map { |i| i.each_slice(h).to_a }
end

def process(data)
  image = construct_image(data, 25, 6)
  min_zero_layer = image.map { |layer| layer.flatten }.min_by { |layer| layer.count(0) }
  min_zero_layer.count(2) * min_zero_layer.count(1)
end

def input
  File.read('./input.txt').split('').map(&:to_i)
end

puts process(input)
