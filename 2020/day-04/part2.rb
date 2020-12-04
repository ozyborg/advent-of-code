def process(data)
  data.count do |d|
    required_fields = %w(byr: iyr: eyr: hgt: hcl: ecl: pid:)

    next false unless required_fields.all? { |f| d.include?(f) }

    d.split(/[\n\s]+/).all? do |dd|
      field, value = dd.split(':')

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
      else
        true
      end
    end
  end
end

def input
  File.read('./input.txt').split("\n\n")
end

puts process(input)
