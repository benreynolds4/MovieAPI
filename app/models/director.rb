class Director
  include Mongoid::Document
  field :name, type: String
  has_and_belongs_to_many :movies, inverse_of: :director
end
