Rails.application.routes.draw do
  resources :movies

   #Post Routes 

   match 'v1/user' => 'api#add_user', via: :post

   match 'v1/movie' => 'api#add_movie', via: :post

   match 'v1/user_movie' => 'api#add_user_movie_information', via: :post



   #Get Routes 

   match 'v1/users_interests' =>  'api#movies_liked_by_all_given_users', via: :get

   match 'v1/user/:id' => 'api#get_user', via: :get
   match 'v1/users' => 'api#get_all_users', via: :get

   match 'v1/movie/:id' => 'api#get_movie', via: :get
   match 'v1/movies' => 'api#get_all_movie', via: :get
   match 'v1/movies_by_filter/:filter_type' => 'api#get_movies_by_filter', via: :get

   match 'v1/search/:resource/:search_term' => 'api#search_media', via: :get

   match 'v1/directors' => 'api#get_directors', via: :get
   match 'v1/directors/:id' => 'api#get_director', via: :get

   match 'v1/actors' => 'api#get_actors', via: :get
   match 'v1/actors/:id' => 'api#get_actor', via: :get


   # match 'v1/delete_all' => 'api#delete_all_instances', via: :get

   
end
