def count(adjs, current, history)
  return 1 if current == 'end'

  adjs[current].sum do |adj|
    next 0 if adj == 'start'
    next 0 if adj == 'end' && history['end']

    visited = false

    if adj.downcase == adj && history[adj]
      next 0 if history.values.include?('VISITED')
      visited = true
    end

    count(adjs, adj, history.merge({ adj => visited ? 'VISITED' : true }))
  end
end

def process(data)
  count(data, 'start', { 'start' => true })
end

def input
  File.readlines(ARGV.first)
      .each.with_object({}) do |l, obj|
        k, v = l.chomp.split('-')
        obj[k] = obj.fetch(k, []) + [v]
        obj[v] = obj.fetch(v, []) + [k]
      end
end

puts process(input)
