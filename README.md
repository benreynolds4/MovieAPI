### Endpoints

##### POST Enpoints
   v1/user 		
   Example Body: 
   {"name":"Conor Whyte"}

   v1/movie 		
   Example Body
   { "movies": [{"name":"Lord Of The Rings", "date":"2017-01-01", "rating":"5", "overview":"", "runtime": "", "dbId":"4323"}, {"name":"Lord Of The Rings 2", "date":"2017-01-02","overview":"", "runtime": "", "rating":"45", "dbId":"4324"}] }

   v1/user_movie 
   Example Body:
   { "user_movies": [{"movie":"5b58f14dc5cbe59c2ca6d2cc", "user":"5b58e742c5cbe59a6b3c52e4", "interested":"1", "not_interested":"0", "watched":"0", "dont_mind":"1"}] }		

##### GET Endpoints
   v1/user/:id 		
   Example Request:
   http://localhost:3000/user/5b58e742c5cbe59a6b3c52e4
   Returns
   All User Saved in App with id.

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
