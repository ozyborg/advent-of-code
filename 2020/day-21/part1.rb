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

  safe_ones.size
end

def input
  File.readlines('./input.txt')
end

puts process(input)
