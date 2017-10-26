### Exercise 5 ###
library(jsonlite)
library(dplyr)
library(httr)

# Read in your api-key.R file (that you'll create). Store your api-key in a variable in that file.
# Write a function that allows you to specify a movie, that does the following:
GetReview <- function(movie) {
  # Construct a search query using YOUR api key
  # The base URL is https://api.nytimes.com/svc/movies/v2/reviews/search.json
  # Your parameters should include a "query" and an "api_key"
  # Note: the HTTR library will take care of spaces in the arguments
  # See the interactive console for more detail:https://developer.nytimes.com/movie_reviews_v2.json#/Console/GET/reviews/search.json
  uri <- 'https://api.nytimes.com/svc/movies/v2/reviews/search.json'
  params <- list(query = movie, api_key = api.key)
  
  # Request data using your search query
  response <- GET(uri, query = params)
  response.body <- content(response, 'text')
  response.data <- fromJSON(response.body)
  
  # What type of variable does this return?
  is.data.frame(response.data) #FALSE
  # data <- as.data.frame(response.data, stringsAsFactors = FALSE)
  
  # Flatten the data stored in the `$results` key of the data returned to you
  results <- flatten(response.data$results)
  
  # From the most recent review, store the headline, short summary, and link to full article each in their own variables
  result <- results[1, ]
  headline <- result$headline
  summary <- result$summary_short
  link <- result$link.url

  # Return an list of the three pieces of information from above
  return(list(headline = headline, summary = summary, link = link))
}

# Test that your function works with a movie of your choice

GetReview('The Cat in the Hat')
