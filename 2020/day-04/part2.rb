def process(data)
  required_fields = %w(byr iyr eyr hgt hcl ecl pid)

  data.count do |d|
    passport_fields = d.split(/[\n\s]+/).map { |p| p.split(':') }.to_h

    next false unless (required_fields - passport_fields.keys).empty?

    passport_fields.all? do |field, value|
      case field
      when 'byr'
        value.to_i >= 1920 && value.to_i <= 2002
      when 'iyr'
        value.to_i >= 2010 && value.to_i <= 2020
      when 'eyr'
        value.to_i >= 2020 && value.to_i <= 2030
      when 'hgt'
        if value.end_with?('cm')
          value.to_i >= 150 && value.to_i <= 193
        elsif value.end_with?('in')
          value.to_i >= 59 && value.to_i <= 76
        else
          false
        end
      when 'hcl'
        value.match(/^#[0-9a-f]{6}$/)
      when 'ecl'
        %w(amb blu brn gry grn hzl oth).include?(value)
      when 'pid'
        value.match(/^[0-9]{9}$/)
      when 'cid'
        true
      else
        false
      end
    end
  end
end

def input
  File.read('./input.txt').split("\n\n")
end

puts process(input)
