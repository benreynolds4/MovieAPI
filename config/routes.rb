Rails.application.routes.draw do
  resources :movies

   #Post Routes 

   match 'v1/user' => 'api#add_user', via: :post

   match 'v1/movie' => 'api#add_movie', via: :post

   match 'v1/user_movie' => 'api#add_user_movie_information', via: :post

   #Get Routes 

   match 'v1/user/:id' => 'api#get_user', via: :get

   match 'v1/movie/:id' => 'api#get_movie', via: :get
   match 'v1/movies' => 'api#get_all_movie', via: :get
   match 'v1/movies_by_filter/:filter_type' => 'api#get_movies_by_filter', via: :get

   match 'v1/search/:resource/:search_term' => 'api#search_media', via: :get

   
end
