def process(data)
  required_fields = %w(byr iyr eyr hgt hcl ecl pid)

  data.count do |d|
    passport_fields = d.split(/[\n\s]+/).map { |p| p.split(':').first }

    (required_fields - passport_fields).empty?
  end
end

def input
  File.read('./input.txt').split("\n\n")
end

puts process(input)
