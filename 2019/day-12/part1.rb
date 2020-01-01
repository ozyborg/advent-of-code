def process(data)
  1000.times do
    res = {}

    4.times do |m|
      3.times do |p|
        res[[m, p]] = (0..3).inject(0) do |sum, x|
          sum + (data[x][p][0] <=> data[m][p][0])
        end
      end
    end

    res.each do |k, v|
      data[k[0]][k[1]][1] += v
      data[k[0]][k[1]][0] += data[k[0]][k[1]][1]
    end
  end

  data.inject(0) do |sum, m|
    pot = m.map { |x| x[0].abs }.sum
    kin = m.map { |x| x[1].abs }.sum
    sum + pot * kin
  end
end

def input
  File.readlines('./input.txt').map do |line|
    line.strip[1..-2].split(', ').map do |p|
      [p.split('=').last.to_i, 0]
    end
  end
end

puts process(input)
