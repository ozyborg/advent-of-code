# copy-paste from https://github.com/acmeism/RosettaCodeData/blob/master/Task/Chinese-remainder-theorem/Ruby/chinese-remainder-theorem-2.rb
def extended_gcd(a, b)
  last_remainder, remainder = a.abs, b.abs
  x, last_x, y, last_y = 0, 1, 1, 0
  while remainder != 0
    last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
    x, last_x = last_x - quotient*x, x
    y, last_y = last_y - quotient*y, y
  end
  return last_remainder, last_x * (a < 0 ? -1 : 1)
end

def invmod(e, et)
  g, x = extended_gcd(e, et)
  if g != 1
    raise 'Multiplicative inverse modulo does not exist!'
  end
  x % et
end

def chinese_remainder(mods, remainders)
  max = mods.inject( :* )  # product of all moduli
  series = remainders.zip(mods).map{ |r,m| (r * max * invmod(max/m, m) / m) }
  series.inject( :+ ) % max
end
# end of copy-paste

def process(data)
  bus_ids = data[1].chomp.split(',').map(&:to_i)

  mods = bus_ids.reject { |x| x == 0 }
  remainders = mods.map { |m| m - (bus_ids.index(m) % m) }

  chinese_remainder(mods, remainders)
end

def input
  File.readlines('./input.txt')
end

puts process(input)
