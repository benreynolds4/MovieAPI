class ApiController < ApplicationController
	skip_before_filter :verify_authenticity_token  

	def get_movies_by_filter
	  filter_type = params[:filter_type]
	  movies = get_movies(filter_type)
	  movies.results[0]['title']
	  render :status => 200,
       :json => { :success => true,
                  :info => "Top Rated Movies",
                  :data => { :movies => movies.results }
       }
	   return
	end

	def search_media
	    resource = params[:resource]
	    search_term = params[:search_term]
		items = find_by_resource(resource, search_term)
		render :status => 200,
       	:json => { :success => true,
                  :info => "Search",
                  :data => { :items => items.results }
       	}
	   return
	end

   def add_user 
   	  	input = JSON.parse(request.body.read)
	    name = input["name"]

	    user = Person.new(name: name)
	    
	    if user.save
	       render :status => 200,
               :json => { :success => true,
                          :info => "User Created",
                          :data => { :user_id => user.id }
               }
               return 
        else
        	render :status => 200,
               :json => { :success => false,
                          :info => "User Creation Failed",
                          :data => { :user_id => 0 }
               }
               return 
	    end 
	   return
   end

   def get_user
   	 user_id = params[:id]
   	 user = Person.find(user_id)
   	 render :status => 200,
               :json => { :success => true,
                          :info => "User",
                          :data => { :user => user }
               }
      return 
   end

   def get_movie
   	 movie_id = params[:id]
   	 movie = Movie.find(movie_id)
   	 render :status => 200,
               :json => { :success => true,
                          :info => "User",
                          :data => { :movie => movie }
               }
      return 
   end

   def get_all_movie
   	movies = Movie.all
   	 render :status => 200,
               :json => { :success => true,
                          :info => "User",
                          :data => { :movies => movies }
               }
      return 
   end

   def add_movie
   	 input = JSON.parse(request.body.read)
   	 movies = input["movies"]

   	 created_movies = []

   	 movies.each do |input_movie| 
   	 	movie_name = input_movie["name"]
   	 	movie_rating = input_movie["rating"]
   	 	movie_date = input_movie["date"]
   	 	movie_dbID = input_movie["dbID"]
   	 	movie_runTime = input_movie["runtime"]
   	 	movie_overview = input_movie["overview"]

   	 	saved_movie = Movie.create(name: movie_name, rating: movie_rating, date: movie_date, dbID: movie_dbID, runtime: movie_runtime, overview: movie_overview)
   	 	created_movies << saved_movie
   	 end
	   
     render :status => 200,
       :json => { :success => true,
                  :info => "Movies Created",
                  :data => { :movies => created_movies }
       }

	   return
   end

   def add_user_movie_information
   	input = JSON.parse(request.body.read)
   	user_movies = input["user_movies"]
   	movies = []
   	change_made = false
   	user_movies.each do |user_movie|
   		user_movie_movie= user_movie["movie"]
   	 	user_movie_user = user_movie["user"]
   	 	user_movie_interested = user_movie["interested"]
   	 	user_movie_not_interested = user_movie["not_interested"]
   	 	user_movie_dont_mind = user_movie["dont_mind"]
   	 	user_movie_watched_by = user_movie["watched"]

   	 	movie = Movie.find(user_movie_movie)
   	 	movies << movie
   	 	user = Person.find(user_movie_user)

   	 	if user_movie_interested == "1"
   	 		movie.interested << user
   	 		movie.dont_mind.delete(user)
   	 		movie.not_interested.delete(user)
   	 		change_made = true
   	 	elsif user_movie_dont_mind == "1"
   	 		change_made = true
   	 		movie.dont_mind << user
   	 		movie.not_interested.delete(user)
   	 		movie.interested.delete(user)
   	 	elsif user_movie_not_interested == "1"
   	 		movie.not_interested << user
   	 		movie.dont_mind.delete(user)
   	 		movie.interested.delete(user)
   	 		change_made = true
   	 	end

   	 	if user_movie_watched_by
   	 		movie.watched_by << user
   	 		change_made = true
   	 	end
   	 	movie.save
   	end

   	if change_made 
	   render :status => 200,
       :json => { :success => true,
                  :info => "User Movies Updated",
                  :data => { :movies => movies }
       }
		return
	else
		render :status => 200,
       :json => { :success => true,
                  :info => "No User Movies Updated",
                  :data => { :movies => movies }
       }
	  return
	end
  end

  private 

  def get_movies(filter_type)
  	case filter_type
  	when "popular"
  		movies = Tmdb::Movie.popular
  	when "top_rated"
  		movies = Tmdb::Movie.top_rated
  	when "now_playing"
  		movies = Tmdb::Movie.now_playing
  	when "upcoming"
  		movies = Tmdb::Movie.upcoming
  	when "latest"
  		movies = Tmdb::Movie.latest
  	end
  	movies
  end

  def find_by_resource(resource, search_term)
  	#resources => person, movie, tv, collection, company, genre
  	search = Tmdb::Search
  	case resource
  	when "person"
  		items = search.person(search_term)
  	when "movie"
  		items = search.movie(search_term)
  	when "tv"
  		items = search.tv(search_term)
  	when "collection"
  		items = search.collection(search_term)
  	when "company"
  		items = search.company(search_term)
  	when "genre"
  		items = search.keyword(search_term)
  	end
  	items
  end 

end
