# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

director = Director.create(name: "Steven Speilberg")
p = Person.create(name: 'Ben Reynolds')
movie = Movie.create(name: "Star Wars")
movie.interested << p
movie.watched_by << p
movie.director << director
movie.save

