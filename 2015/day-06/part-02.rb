def process(data)
  lights = {}

  data.each do |d|
    (d[1]..d[3]).each do |x|
      (d[2]..d[4]).each do |y|
         case d[0]
         when 'turn on'
           lights[[x, y]] = lights.fetch([x, y], 0) + 1
         when 'turn off'
           lights[[x, y]] = lights.fetch([x, y], 0) - 1
           lights[[x, y]] = 0 if lights[[x, y]].negative?
         when 'toggle'
           lights[[x, y]] = lights.fetch([x, y], 0) + 2
         else
         end
      end
    end
  end

  lights.values.sum
end

def input
  File.read(ARGV.first).scan(/(.*) (\d+),(\d+) through (\d+),(\d+)/).map do |line|
    [line.first] + line.drop(1).map(&:to_i)
  end
end

puts process input

