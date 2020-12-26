$signals = {}

def signal(conf, wire)
  return wire.to_i unless conf[wire]

  instruction = conf[wire].split(' ')

  $signals[wire] ||= case instruction.size
    when 1
      signal(conf, instruction[0])
    when 2
      65536 + ~signal(conf, instruction[1])
    when 3
      case instruction[1]
      when 'AND'
        signal(conf, instruction[0]) & signal(conf, instruction[2])
      when 'OR'
        signal(conf, instruction[0]) | signal(conf, instruction[2])
      when 'LSHIFT'
        signal(conf, instruction[0]) << instruction[2].to_i
      when 'RSHIFT'
        signal(conf, instruction[0]) >> instruction[2].to_i
      end
    end
end

def process(data)
  data['b'] = signal(data, 'a').to_s
  $signals.clear
  signal(data, 'a')
end

def input
  File.read(ARGV.first).scan(/(.+) -> (.+)/).map(&:reverse).to_h
end

puts process input

