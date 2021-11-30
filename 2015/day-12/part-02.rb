require 'json'

def leaves(collection)
  values = collection.is_a?(Hash) ? collection.values : collection

  return [] if collection.is_a?(Hash) && values.include?('red')

  values.flat_map do |v|
    v.is_a?(Hash) || v.is_a?(Array) ? leaves(v) : v
  end
end

def process(data)
  leaves(data).map(&:to_i).sum
end

def input
  JSON.parse(File.read(ARGV.first))
end

puts process(input)

