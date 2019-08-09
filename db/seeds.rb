require 'json'
require 'open-uri'

puts 'Cleaning database...'
Dose.destroy_all
Cocktail.destroy_all
Ingredient.destroy_all

puts 'Creating ingredients...'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_serialized = open(url).read
ingredients = JSON.parse(ingredients_serialized)
ings = []

ingredients['drinks'].each do |ingredient|
  ings << Ingredient.create(name: ingredient['strIngredient1'])
end

puts 'Creating cocktails...'

cocktails = [['Moscow Mule', 'https://res.cloudinary.com/edouard-de-prez/image/upload/v1565350664/moscow-mule_o94w1m.jpg'], ['Pina Colada', 'https://res.cloudinary.com/edouard-de-prez/image/upload/v1565350664/pina-colada_syf4dq.jpg'], ['Gin Tonic', 'https://res.cloudinary.com/edouard-de-prez/image/upload/v1565350664/gin-tonic_mrykp9.jpg'], ['Vodka Cola', 'https://res.cloudinary.com/edouard-de-prez/image/upload/v1565354586/vodka-and-coke-drink-recipe_rzdypf.jpg']]
cocktails.each do |cocktail|
  coc = Cocktail.create(name: cocktail[0])
  coc.remote_photo_url = cocktail[1]
  4.times do
    dose = Dose.new(description: "#{Random.new.rand(1..100)}cl")
    dose.cocktail = coc
    dose.ingredient = ings.sample
    dose.save
  end
  coc.save
end

puts 'Finished!'
# Ingredient.create(name: "mint leaves")
