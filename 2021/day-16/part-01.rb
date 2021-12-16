def deep_sum(packet, k)
  packet.fetch(k, 0) + packet.fetch(:packets, []).map { |p| deep_sum(p, k) }.sum
end

def extract_packet(data)
  packet = {
    version: data.shift(3).join.to_i(2),
    type_id: data.shift(3).join.to_i(2)
  }

  if packet[:type_id] != 4
    packet_length = 0
    packet_numbers = 0
    packets = []

    length_type = data.shift(1).join.to_i(2)
    packet_length = data.shift(15).join.to_i(2) if length_type == 0
    packet_numbers = data.shift(11).join.to_i(2) if length_type == 1

    old_length = data.size

    loop do
      break if length_type == 0 && old_length - data.size == packet_length
      break if length_type == 1 && packets.size == packet_numbers

      packets << extract_packet(data)
    end

    return packet.merge(packets: packets)
  else
    value = []
    length = 0

    loop do
      control = data.shift(1).join.to_i(2)
      value += data.shift(4)
      length += 5
      break if control == 0
    end

    return packet.merge(value: value.flatten.join.to_i(2))
  end
end

def process(data)
  packet = extract_packet(data)

  return deep_sum(packet, :version)
end

def input
  File.read(ARGV.first).chars.map { |c| "%04b" % c.hex }.join.chars
end

puts process(input)
