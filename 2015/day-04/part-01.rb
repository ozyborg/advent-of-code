require 'digest'

def process(data)
  (1..).each do |i|
    break i if Digest::MD5.hexdigest("#{data}#{i}").start_with?('00000')
  end
end

def input
  File.read(ARGV.first).chomp
end

puts process(input)

