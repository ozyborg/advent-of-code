def process(data)
  cubes = data

  # map the boundary values of each dimension
  bounds = 4.times.map do |d|
    (cubes.keys.map { |k| k[d] }.min..cubes.keys.map { |k| k[d] }.max).to_a
  end

  6.times do
    next_cubes = {}

    # let's expand our pocket universe!
    bounds.map! do |b|
      [b.first - 1] + b + [b.last + 1]
    end

    # generate all possible points for the current universe
    bounds.reduce(&:product).map(&:flatten).map do |xyzw|
      # generate all possible adjacent points for a single point
      adjs = ([-1, 0, 1].repeated_permutation(4).to_a - [[0, 0, 0, 0]]).map do |d|
        [xyzw, d].transpose.map(&:sum) # don't panic, it's just two vectors getting summed!
      end

      active_adjs = adjs.count { |adj| cubes[adj] == '#' }

      value = cubes.fetch(xyzw, '.')

      if value == '#' && active_adjs != 2 && active_adjs != 3
        next_cubes[xyzw] = '.'
      elsif value == '.' && active_adjs == 3
        next_cubes[xyzw] = '#'
      else
        next_cubes[xyzw] = value
      end
    end

    cubes = next_cubes
  end

  cubes.values.count('#')
end

def input
  File.readlines('./input.txt').map.with_index do |xs, y|
    xs.chomp.chars.map.with_index do |v, x|
      [[x, y, 0, 0], v]
    end
  end.flatten(1).to_h
end

puts process(input)
