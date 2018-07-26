class Movie
  include Mongoid::Document
  field :name, type: String
  field :rating, type: String
  field :date, type: String
  field :dbID, type: String
  field :runtime, type: String
  field :overview, type: String
  has_and_belongs_to_many :interested, class_name: "Person", inverse_of: :interests
  has_and_belongs_to_many :not_interested, class_name: "Person", inverse_of: :non_interests
  has_and_belongs_to_many :dont_mind, class_name: "Person", inverse_of: :dont_mind
  has_and_belongs_to_many :watched_by, class_name: "Person", inverse_of: :watched
  has_and_belongs_to_many :director, inverse_of: :movies
  has_and_belongs_to_many :actor, inverse_of: :movies

  def get_directors_string
  	directors_string = ''
  	director.each do |director|
  		directors_string += director.name
  	end
  	directors_string
  end

  def get_interested_people_string
  	interested_people = ''
  	interested.each do |person|
  		interested_people += person.name + ' ' + person.id
  	end
  	interested_people
  end
end
