class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:show]

  def index
    @cocktails = Cocktail.all
    @cocktail_hash = Hash.new
    @cocktails.each do |cocktail|
      ingredients = []
      cocktail.ingredients.each do |ingredient|
        ingredients << ingredient.name.downcase
      end
      @cocktail_hash[cocktail] = [cocktail.name, ingredients, cocktail.photo]
    end
  end

  def show
    @dose_hash = Hash.new
    @cocktail.doses.each do |dose|
      @dose_hash[dose] = [dose.description, dose.ingredient.name]
    end
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
