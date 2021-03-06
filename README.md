### Endpoints

##### POST Enpoints
   v1/user 		
   Example Body: 
   {"name":"Conor Whyte"}

   v1/movie 		
   Example Body
   { "movies": [{"name":"Lord Of The Rings", "date":"2017-01-01", "rating":"5", "overview":"", "runtime": "", "dbId":"4323", "liked_by_users":"[5b58e742c5cbe59a6b3c52e4, 5b58e742c5cbe59a6b3c52e4]"}, {"name":"Lord Of The Rings 2", "date":"2017-01-02","overview":"", "runtime": "", "rating":"45", "dbId":"4324", "liked_by_users":"[5b58e742c5cbe59a6b3c52e4]", 
   "actors":[{"name":"John Snow"},{"name":"Walter White"}], "directors":[{"name":"Brian Murray"},{"name":"Conor Whyte"}, "imdb":"8.5", "rotten_tomatoes":"9.8", "image_source":"https://movies.com/image.jpg" } ] }

   v1/user_movie 
   Example Body:
   { "user_movies": [{"movie":"5b58f14dc5cbe59c2ca6d2cc", "user":"5b58e742c5cbe59a6b3c52e4", "interested":"1", "not_interested":"0", "watched":"0", "dont_mind":"1"}] }		

##### GET Endpoints
   v1/user/:id 		
   Example Request:
   http://localhost:3000/user/5b58e742c5cbe59a6b3c52e4
   Returns
   All User Saved in App with id.

   v1/users       
   Example Request:
   http://localhost:3000/users
   Returns
   All Users

   v1/movie/:id 	
   Example Request:
   http://localhost:3000/movie/5b58e742c5cbe59a6b3c52e4	
   Returns
   All Movie Saved in App with id.

   v1/movies 
   Example Request:
   http://localhost:3000/v1/movies
   Returns
   All Movies Saved in App


   v1/movies_by_filter/:filter_type 
   Example Request:
   http://localhost:3000/v1/movies_by_filter/popular
   Returns
   All Popular movies of the day in the movie database api

   v1/search/:resource/:search_term 	
   Example Request:
   http://localhost:3000/v1/search/movie/james gunn
   Returns
   Searches the movie api database for james gunn


   v1/users_interests?user_ids[]=:user_id_1$user_ids[]=:user_id_1
   http://localhost:3000/v1/users_interests?user_ids[]=5b58e742c5cbe59a6b3c52e4&user_ids[]=5b58e742c5cbe59a6b3c52e4
   Returns
   List of movies liked by inputted users, ordered by number of users given liked. 


   v1/actors/5b85c0c1c5cbe53a004e4498
   http://localhost:3000/v1/actors/5b85c0c1c5cbe53a004e4498
   Returns 
   Actor by id. 

   v1/actors
   http://localhost:3000/v1/actors
   Returns 
   All Actors

   v1/directors/5b85c0c1c5cbe53a004e4498
   http://localhost:3000/v1/directors/5b85c0c1c5cbe53a004e4498
   Returns 
   Director by id. 

   v1/directors
   http://localhost:3000/v1/directors
   Returns 
   All Directors



