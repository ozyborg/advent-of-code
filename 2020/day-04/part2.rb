def process(data)
  required_fields = %w(byr iyr eyr hgt hcl ecl pid)

  data.count do |d|
    passport = d.split(/[\n\s]+/).map { |p| p.split(':') }.to_h

    (required_fields - passport.keys).empty? &&
    (passport['byr'].length == 4 && passport['byr'].to_i >= 1920 && passport['byr'].to_i <= 2002) &&
    (passport['iyr'].length == 4 && passport['iyr'].to_i >= 2010 && passport['iyr'].to_i <= 2020) &&
    (passport['eyr'].length == 4 && passport['eyr'].to_i >= 2020 && passport['eyr'].to_i <= 2030) &&
    (passport['hgt'].end_with?('cm') || passport['hgt'].end_with?('in')) &&
    (!(passport['hgt'].end_with?('cm') ^ (passport['hgt'].to_i >= 150 && passport['hgt'].to_i <= 193))) &&
    (!(passport['hgt'].end_with?('in') ^ (passport['hgt'].to_i >= 59 && passport['hgt'].to_i <= 76))) &&
    (passport['hcl'].match(/^#[0-9a-f]{6}$/)) &&
    (passport['ecl'].match(/^amb|blu|brn|gry|grn|hzl|oth$/)) &&
    (passport['pid'].match(/^[0-9]{9}$/))
  end
end

def input
  File.read('./input.txt').split("\n\n")
end

puts process(input)
