def process(data)
  jolt_diff_counts = {
    1 => 0,
    2 => 0,
    3 => 1
  }

  ([0] + data.sort).each_cons(2) do |a1, a2|
    jolt_diff_counts[a2 - a1] += 1
  end

  jolt_diff_counts[1] * jolt_diff_counts[3]
end

def input
  File.readlines('./input.txt').map(&:to_i)
end

puts process(input)
