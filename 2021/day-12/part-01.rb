def count(adjs, current, history)
  return 1 if current == 'end'

  adjs[current].sum do |adj|
    next 0 if history[adj] && adj.downcase == adj

    count(adjs, adj, history.merge({ adj => true }))
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
