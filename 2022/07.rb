def dir_sizes(data)
  current = []
  dirs = Hash.new(0)

  data.each do |d|
    case d[0]
    when '$'
      case d[1]
      when 'cd'
        case d[2]
        when '..'
          current.pop
        else
          current << d[2]
        end
      when 'ls'
      end
    when 'dir'
    else
      (1..current.size).each { |s| dirs[current.first(s)] += d[0].to_i }
    end
  end

  dirs
end

def part_2(data)
  dir_sizes = dir_sizes(data)

  target = 30000000 - (70000000 - dir_sizes[["/"]])

  dir_sizes.values.sort.find { |v| v >= target }
end

def part_1(data)
  dir_sizes(data).select { |k, v| v <= 100000 }.values.sum
end

def input
  File.read('./inputs/07.txt').split("\n").map { |l| l.split(" ") }
end

puts part_1(input)
puts part_2(input)
