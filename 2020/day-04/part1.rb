def process(data)
  data.count do |d|
    required_fields = %w(byr: iyr: eyr: hgt: hcl: ecl: pid:)
    required_fields.all? { |f| d.include?(f) }
  end
end

def input
  File.read('./input.txt').split("\n\n")
end

puts process(input)
