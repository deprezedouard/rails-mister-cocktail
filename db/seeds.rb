require 'json'
require 'open-uri'

puts 'Cleaning database...'
Ingredient.destroy_all

puts 'Creating ingredients...'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_serialized = open(url).read
ingredients = JSON.parse(ingredients_serialized)

ingredients['drinks'].each do |ingredient|
  Ingredient.create(name: ingredient['strIngredient1'])
end

puts 'Finished!'
# Ingredient.create(name: "mint leaves")
