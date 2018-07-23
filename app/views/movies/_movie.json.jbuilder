json.extract! movie, :id, :name, :rating, :date, :dbID, :created_at, :updated_at
json.url movie_url(movie, format: :json)
