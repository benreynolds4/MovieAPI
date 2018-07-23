class Movie
  include Mongoid::Document
  field :name, type: String
  field :rating, type: String
  field :date, type: String
  field :dbID, type: String
  has_many :interests
end
