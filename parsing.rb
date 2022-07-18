require 'nokogiri'
require 'open-uri'

class Parsing
  def scrape(ingredient)
    url = "https://www.allrecipes.com/search/results/?search=#{ingredient}"
    doc = Nokogiri::HTML(URI.open(url).read)    
    recipes_data = {}
    cards = doc.search(".card__detailsContainer-left")
    cards.take(5).each do |card|
      link = card.search(".card__titleLink").attr('href').value
      recipe_doc = Nokogiri::HTML(URI.open(link).read)
      prep = recipe_doc.search(".recipe-meta-item-body.elementFont__subtitle").first.text.gsub(/s/, '')
      title = card.search(".card__titleLink").attr('title').value
      description = card.search(".card__summary").text.split(/\n/).join.strip
      rating = card.search(".review-star-text").text.gsub(/[^\d\.]/, '')
      recipes_data[title]  = []
      recipes_data[title]  << link
      recipes_data[title]  << description
      recipes_data[title]  << prep
      recipes_data[title]  << rating
    end
    recipes_data
  end
end
