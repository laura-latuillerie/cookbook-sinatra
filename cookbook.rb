require_relative "recipe"
require "csv"

class Cookbook
  attr_accessor :recipes

  def initialize(csv_file_path)
    @recipes = []
    @csv = csv_file_path
    CSV.foreach(csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4])
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_csv
  end

  private

  def update_csv
    CSV.open(@csv, "wb") do |csv|
      @recipes.each do |recipe|
        csv << [recipe.done, recipe.name, recipe.description, recipe.preptime, recipe.rating]
      end
    end
  end
end
