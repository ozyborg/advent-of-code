def process(data)
  required_fields = %w(byr iyr eyr hgt hcl ecl pid)

  data.count do |d|
    passport = d.split(/[\n\s]+/).map { |p| p.split(':') }.to_h

    (required_fields - passport.keys).empty? &&
    (passport['byr'].match(/^(19[2-9][0-9])|(200[0-2])$/)) &&
    (passport['iyr'].match(/^(201[0-9])|(2020)$/)) &&
    (passport['eyr'].match(/^(202[0-9])|(2030)$/)) &&
    (passport['hgt'].match(/^(1(([5-8][0-9])|(9[0-3]))cm)|(((59)|(6[0-9])|(7[0-6]))in)$/)) &&
    (passport['hcl'].match(/^#[0-9a-f]{6}$/)) &&
    (passport['ecl'].match(/^amb|blu|brn|gry|grn|hzl|oth$/)) &&
    (passport['pid'].match(/^[0-9]{9}$/))
  end
end

def input
  File.read('./input.txt').split("\n\n")
end

puts process(input)
