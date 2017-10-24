### Exercise 1 ###

# Load the httr and jsonlite libraries for accessing data
library('httr')
library('jsonlite')

## For these questions, look at the API documentation to identify the appropriate endpoint and information.
## Then send GET() request to fetch the data, then extract the answer to the question

# How many forks does the most popular repository (by number of forks) have when you search for the term 'd3'?
# (search for the term, and sort descending by the number of forks)
uri <- paste0('https://api.github.com', '/search/repositories')
params <- list(
  q = 'd3',
  sort = 'forks'
)
response <- GET(uri, query = params)
response.body <- content(response, 'text')
response.data <- fromJSON(response.body)
most.popular.repo <- response.data$items[1, ]
print(paste('Most popular repo is', most.popular.repo$name, 'with', most.popular.repo$forks_count, 'forks'))

# How many public repositories does our course organization have?
course.organization = 'info201a-au17'
uri <- paste0('https://api.github.com', '/orgs/', course.organization)
response <- GET(uri)
response.body <- content(response, 'text')
response.data <- fromJSON(response.body)
print(paste(course.organization, 'has', response.data$public_repos, 'public repositories'))