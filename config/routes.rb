Rails.application.routes.draw do
  resources :movies

   match 'v1/user' => 'api#add_user', via: :post
   match 'v1/user/:id' => 'api#get_user', via: :get
   match 'v1/movie/:id' => 'api#get_movie', via: :get
   match 'v1/movies' => 'api#get_all_movie', via: :get
   match 'v1/movie' => 'api#add_movie', via: :post
   match 'v1/user_movie' => 'api#add_user_movie_information', via: :post
end
