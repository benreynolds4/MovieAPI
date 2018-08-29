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

  def movies_liked_by_person(id)
    user = Person.find(id)
    user.interests
  end 

  def movies_liked_by_all_given_users 
    # Order by movies liked by all then by all - 1 then by all - 2 etc. 
    user_ids = params[:user_ids]
    movies = {}
    user_ids.each do |id|
      movies_liked_by_person(id).each do |movie|  
        if movies[movie].nil?
          print "INITAING"
           movies[movie] = 1
        else 
          print "ADDING"
          movies[movie] += 1
        end
      end 
    end

    result = {}
    print movies 
    movies.each do |key, value| 
      if result[value].nil?
        result[value] = key.to_json
      else 
        result[value] = result[value] << key.to_json
      end
    end

    render :status => 200,
     :json => { :success => true,
                :info => "Movies",
                :data => { :movies => result }
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


   def get_actor
     actor_id = params[:id]
     actor = Actor.find(actor_id)
     render :status => 200,
               :json => { :success => true,
                          :info => "Actor",
                          :data => { :actor => actor }
               }
      return 
   end

   def get_actors
    actors = Actor.all
     render :status => 200,
               :json => { :success => true,
                          :info => "Actors",
                          :data => { :actors => actors }
               }
      return 
   end

   def get_director
     director_id = params[:id]
     director = Director.find(director_id)
     render :status => 200,
               :json => { :success => true,
                          :info => "Director",
                          :data => { :director => director }
               }
      return 
   end

   def get_directors
    directors = Director.all
    render :status => 200,
               :json => { :success => true,
                          :info => "Directors",
                          :data => { :directors => directors }
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

   def get_all_users
    users = Person.all
     render :status => 200,
               :json => { :success => true,
                          :info => "User",
                          :data => { :users => users }
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
    movies = movies.sort_by {|movie| movie.interested.count}.reverse! 

   	 render :status => 200,
               :json => { :success => true,
                          :info => "Movies",
                          :data => { :movies => movies }
               }
      return 
   end


   def delete_all_instances
    Movie.delete_all
    Person.delete_all
    Actor.delete_all
    Director.delete_all
         render :status => 200,
               :json => { :success => true,
                          :info => "Deleted all instances",
                          :data => {}
               }
      return 
   end



   def add_movie
   	 input = JSON.parse(request.body.read)
   	 movies = input["movies"]

   	 created_movies = []

   	 movies.each do |input_movie| 
      movie_directors = []
      movie_actors = []
   	 	movie_name = input_movie["name"]
   	 	movie_rating = input_movie["rating"]
      # Add Genre, directors, actors and should add user information
   	 	movie_date = input_movie["date"]
   	 	movie_dbID = input_movie["dbID"]
   	 	movie_runtime = input_movie["runtime"]
   	 	movie_overview = input_movie["overview"]

      movie_rotten_tomatoes = input_movie["rotten_tomatoes"]
      movie_imdb = input_movie["imdb"]
      movie_image_source = input_movie["image_source"]
      movie_actors = input_movie["actors"]
      movie_directors = input_movie["directors"]
      actors = []
      directors = []

      if not movie_actors.nil?
        movie_actors.each do |actor_input|
          if not Actor.where(name:actor_input['name']).exists?
            actors << Actor.new(name:actor_input['name'])
          else 
            actors << Actor.find_by(name:actor_input['name'])
          end
        end 
     end

     if not movie_directors.nil?
        movie_directors.each do |director_input|
          if not Director.where(name:director_input['name']).exists?
            directors << Director.new(name:director_input['name'])
          else 
            directors << Director.find_by(name:director_input['name'])
          end
        end 
     end

      if Movie.where(name: movie_name).exists?
        saved_movie = Movie.where(name: movie_name).first
      else
        print "NEW MOVIE"
   	 	  saved_movie = Movie.create(name: movie_name, rating: movie_rating, date: movie_date, dbID: movie_dbID, runtime: movie_runtime, overview: movie_overview, rotten_tomatoes: movie_rotten_tomatoes, imdb: movie_imdb, image_source: movie_image_source)


        saved_movie.actors << actors
        saved_movie.director << directors
      end

      input_movie["liked_by_users"].tr('[]', '').split(',').map(&:to_s).each do |user_id|
        user_movie = {}
        user_movie["user"] = user_id.to_s
        user_movie['movie'] = saved_movie.id
        user_movie["interested"]  = true
        add_user_movie_information(user_movie)
      end 

   	 	created_movies << saved_movie
   	 end
	   
     render :status => 200,
       :json => { :success => true,
                  :info => "Movies Created",
                  :data => { :movies => created_movies }
       }

	   return
   end


   def add_user_movie_information(user_movie = nil)

    if user_movie.nil? 
      api_request = true
      input = JSON.parse(request.body.read)
   	  user_movies = input["user_movies"]
    else 
      api_request = false
      user_movies = user_movie
      movie = Movie.find(user_movie['movie'])
      user_id = user_movie['user']
      user_interested = user_movie["interested"]
      movie_id = movie.id
    end

   	movies = []

   	change_made = false
   	user_movies.each do |user_movie|
   	 	user_movie_not_interested = false 
   	 	user_movie_dont_mind = false
   	 	user_movie_watched_by = false

      if api_request
       user_id = user_movie['user']
       user_interested = user_movie["interested"]
       movie_id = user_movie['movie']
     end 

   	 	movie = Movie.find(movie_id)
   	 	movies << movie
   	 	user = Person.find(user_id)

   	 	if user_interested 
        print "Interested"
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
       movie.interested.each do |user|
        print user.name
       end
   	end

    if api_request 
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
  end

  private 

  def get_users_for_ids(user_ids)
    users = []
    user_ids.each do |id|
      users.append(Person.find(id))
    end
    users
  end

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

  def common_movies_by_filter(category, users_ids)
      users = get_users_for_ids(users_ids)
      if category = 'interested'
        users.each do |user| 
        end
      elsif category = 'dont_mind'
      elsif category = 'watched'
      elsif category = 'not_interested'
      end
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
