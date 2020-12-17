def process(data)
  cubes = data

  bounds = 3.times.map do |d|
    (cubes.keys.map { |k| k[d] }.min..cubes.keys.map { |k| k[d] }.max).to_a
  end

  6.times do
    next_cubes = {}

    bounds.map! do |b|
      [b.first - 1] + b + [b.last + 1]
    end

    bounds.reduce(&:product).map(&:flatten).map do |xyz|
      adjs = ([-1, 0, 1].repeated_permutation(3).to_a - [[0, 0, 0]]).map do |d|
        [xyz, d].transpose.map(&:sum)
      end

      active_adjs = adjs.count { |adj| cubes[adj] == '#' }

      value = cubes.fetch(xyz, '.')

      if value == '#' && active_adjs != 2 && active_adjs != 3
        next_cubes[xyz] = '.'
      elsif value == '.' && active_adjs == 3
        next_cubes[xyz] = '#'
      else
        next_cubes[xyz] = value
      end
    end

    cubes = next_cubes
  end

  cubes.values.count('#')
end

def input
  File.readlines('./input.txt').map.with_index do |xs, y|
    xs.chomp.chars.map.with_index do |v, x|
      [[x, y, 0], v]
    end
  end.flatten(1).to_h
end

puts process(input)
