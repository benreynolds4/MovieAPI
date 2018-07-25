class Person
  include Mongoid::Document
  field :name, type: String
  has_and_belongs_to_many :interests, class_name: "Movie", inverse_of: :interested
  has_and_belongs_to_many :non_interests, class_name: "Movie", inverse_of: :not_interested
  has_and_belongs_to_many :watched, class_name: "Movie", inverse_of: :watched_by
end
