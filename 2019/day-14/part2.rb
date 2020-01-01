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

  produce("1 FUEL", data, inventory)
  unit_ore = inventory['ORE'].abs

  candidates = {}
  left = 1000000000000
  right = 0

  loop do
    break if left - right < 2
    middle = (left + right) / 2

    inventory.transform_values!{|v| 0}
    inventory['ORE'] = 1000000000000
    inventory['FUEL'] = 0
    produce("#{middle} FUEL", data, inventory)

    if inventory['ORE'] > 0 && inventory['ORE'] < unit_ore
      candidates[middle] = inventory['ORE']
    end
    left = middle if inventory['ORE'] < 0
    right = middle if inventory['ORE'] > 0
  end

  candidates.min_by { |k, v| v }.first
end

def input
  File.readlines('./input.txt').map do |line|
    line.strip.split(' => ').reverse
  end.to_h
end

puts process(input)
