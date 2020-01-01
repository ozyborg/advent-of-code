def produce(chemical, formulas, inventory)
  demanded_qty, name = chemical.split(' ')
  demanded_qty = demanded_qty.to_i

  formula_key = formulas.keys.find { |s| s.include?(name) }
  supplied_qty = formula_key.split(' ').first.to_i

  qty_to_produce = demanded_qty - inventory[name]
  count = (qty_to_produce.to_f / supplied_qty).ceil.to_i

  inventory[name] += (supplied_qty * count)

  formulas[formula_key].split(',').each do |c|
    qty, name = c.strip.split(' ')
    qty = qty.to_i * count
    if name != 'ORE' && inventory[name] < qty
      produce("#{qty} #{name}", formulas, inventory)
    end
    inventory[name] -= qty
  end
end

def process(data)
  inventory = {}
  inventory['FUEL'] = 0

  data.each do |k, v|
    v.split(',').each do |s|
      inventory[s.strip.split(' ').last] = 0
    end
  end

  produce('1 FUEL', data, inventory)

  inventory['ORE'].abs
end

def input
  File.readlines('./input.txt').map do |line|
    line.strip.split(' => ').reverse
  end.to_h
end

puts process(input)
