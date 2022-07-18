class Recipe
  attr_reader :done, :name, :description, :preptime, :rating

  def initialize(done = false, name, description, preptime, rating)
    @name = name
    @description = description
    @preptime = preptime
    @rating = rating
    @done = done
  end
  
  def done?
    @done
  end

  def mark_as_done!
    @done = true
    
  end

  def mark_as_undone!
    @done = false
  end
end
