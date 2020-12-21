def process(data)
  possible_ingredients = {}
  all_ingredients = []

  list = data.map { |d| d.scan(/(.*) \(contains (.*)\)/).first }

  list.each do |l|
    ingredients, allergens = l
    ingredients = ingredients.split(' ')
    allergens = allergens.split(', ')

    all_ingredients += ingredients

    allergens.each do |a|
      possible_ingredients[a] = possible_ingredients.fetch(a, ingredients) & ingredients
    end
  end

  safe_ones = all_ingredients - possible_ingredients.values.reduce(:|)

  possible_ingredients = possible_ingredients.sort_by { |k, v| v.size }.to_h

  result = {}

  until possible_ingredients.values.all?(&:empty?)
    possible_ingredients.each do |k, v|
      if v.one?
        result[k] = v.first
        possible_ingredients.transform_values! { |vv| vv - v }
      end
    end
  end

  result.sort.to_h.values.join(',')
end

def input
  File.readlines('./input.txt')
end

puts process(input)
