<div align="center">
  <h1>Streamr API</h1>
  <h1>-WIP-</h1>
</div>

## Table of Contents
- [Project Overview](#project-overview)
- [Learning Goals](#learning-goals)
- [Setup](#setup)
- [Endpoints](#endpoints)
- [Schema](#schema)
- [Gems](#gems)


## Project Overview
This API was built over the course of several days as practice for completing take-home technical challenges found in interviews. The 


## Setup
This application uses Ruby 2.7.2 and Rails 5.2.8.1

1. Clone the repository
2. Navigate into the root directory
3. Install gem packages: `bundle install`
4. Setup the database: `rails db:{drop,create,migrate}`
6. Run `rails s` to start the server
7. You may run the RSpec test suite locally with `bundle exec rspec`

## Endpoints
Back End Server: https://streamr_be.herokuapp.com/

This application uses GraphQL and therefore all requests should be sent as `POST https://streamr-be.herokuapp.com/graphql` with the appropriate query in the request body. 

After setup, non-static documentation is available using GraphiQL, GraphQL's IDE, by visiting `localhost:3000/graphiql`. Static documentation is provided below to give an initial sense of available data.

- ### Fetch Users
<details close>
<summary>Fetch All Users in the Database</summary>
<br>
Request Body: <br>
  
```
  query {
    users {
        id
        username
        avatarUrl
    }
  }
```
  
JSON Response Example: 
```json 
  {
  "data": {
    "users": [
      {
        "id": "1",
        "username": "snoop_dogg",
        "avatarUrl": "https://cdn-icons-png.flaticon.com/512/3940/3940414.png"
      },
      {
        "id": "2",
        "username": "martha_stewart",
        "avatarUrl": "https://cdn-icons-png.flaticon.com/512/3940/3940448.png"
      },
      {...},
      {...}
    ]
  }
```
</details>

<details close>
<summary>Fetch One User From the Database by ID</summary>
<br>
Request Body: <br>
  
```
query {
	fetchUser (
  	id: 5
  )
  {
    id
    username
    avatarUrl
    watchlistItems {
      show {
        tmdbId
        title
        releaseYear
        posterUrl
        mediaType
      }
    }
    recommendations {
      id
      recommendeeId
      recommender {
        id
        username
        avatarUrl
      }
      show {
        tmdbId
        title
        releaseYear
        rating
        genres
        posterUrl
        mediaType
      }
      createdAt
    }
  }
}
```
  
JSON Response Example: 
```json 
 {
  "data": {
    "fetchUser": {
      "id": "5",
      "username": "the_burger_king",
      "avatarUrl": "https://cdn-icons-png.flaticon.com/512/3940/3940429.png",
      "watchlistItems": [
        {
          "show": {
            "tmdbId": 76331,
            "title": "Succession",
            "releaseYear": "2018",
            "posterUrl": "https://image.tmdb.org/t/p/w500/e2X32jUfJ2kb4QtNg3WCTnLyGxD.jpg",
            "mediaType": "tv"
          }
        },
        {..},
        {..}
      ],
      "recommendations": [
        {
          "id": "5",
          "recommendeeId": 5,
          "recommender": {
            "id": "4",
            "username": "sean_not_shaun",
            "avatarUrl": "https://cdn-icons-png.flaticon.com/512/3940/3940421.png"
          },
          "show": {
            "tmdbId": 4608,
            "title": "30 Rock",
            "releaseYear": "2006",
            "rating": 7.45,
            "genres": [
              "Comedy"
            ],
            "posterUrl": "https://image.tmdb.org/t/p/w500/k3RbNzPEPW0cmkfkn1xVCTk3Qde.jpg",
            "mediaType": "tv"
          },
          "createdAt": "2023-02-12T19:29:41Z"
        },
        {..},
        {..}
      ]
    }
  }
}
```
</details>

- ### Shows
<details close>

<summary>Search for Shows with Keyword</summary>
<br>
Request Body: <br>

```
  query {
    shows(
        query: "30 Rock"
    )
    {
        tmdbId
        title
        imageUrl
        yearCreated
        mediaType
        rating
        genres
    }
}
```

JSON Response Example: 
```json 
  {
  "data": {
    "shows": [
      {
        "tmdbId": 4608,
        "title": "30 Rock",
        "imageUrl": "https://image.tmdb.org/t/p/w500//k3RbNzPEPW0cmkfkn1xVCTk3Qde.jpg",
        "yearCreated": "2006-10-11",
        "mediaType": "tv",
        "rating": 7.45,
        "genres": [
          "Comedy"
        ]
      },
      {..},
      {..},
    ]
  }
```
</details>

<details close>

<summary>Fetch Show Details by ID</summary>
<br>
  Note: The argument `userId` is only required if the recommendedBy field is present in query <br>
Request Body: <br>

```
  query {
    showDetails(
        tmdbId: 4608
        userId: 1
      	mediaType: "tv"
    )
    {
        tmdbId
        title
        releaseYear
        streamingService {
          logoPath
          providerName
        }
        posterUrl
        genres
        rating
        summary
      	mediaType
        recommendedBy {
                id
                username
                avatarUrl
        }
    	 
    }
}
```

JSON Response Example: 
```json 
  {
  "data": {
    "showDetails": {
      "tmdbId": 4608,
      "title": "30 Rock",
      "releaseYear": "2006",
      "streamingService": [
        {
          "logoPath": "https://image.tmdb.org/t/p/w500/zxrVdFjIjLqkfnwyghnfywTn3Lh.jpg",
          "providerName": "Hulu"
        },
        {..},
        {..}
      ],
      "posterUrl": "https://image.tmdb.org/t/p/w500/k3RbNzPEPW0cmkfkn1xVCTk3Qde.jpg",
      "genres": [
        "Comedy"
      ],
      "rating": 7.45,
      "summary": "Liz Lemon, the head writer...",
      "mediaType": "tv",
      "recommendedBy": [
        {
          "id": "2",
          "username": "martha_stewart",
          "avatarUrl": "https://cdn-icons-png.flaticon.com/512/3940/3940448.png"
        },
        {..},
        {..}
      ]
    }
  }
}
```
</details>

- ### Recommendations
<details close>

<summary>Create New Recommendation</summary>
<br>
Request Body: <br>

```
  mutation {
    createRecommendation (
        tmdbId: 4608,
        recommenderId: 1,
        recommendeeId: 2,
        mediaType: "tv"
    )
    {
        id
        tmdbId
        recommenderId
        recommendeeId
    }
}
```

JSON Response Example: 
```json 
  {
  "data": {
    "createRecommendation": {
      "id": "30",
      "tmdbId": 4608,
      "recommenderId": 1,
      "recommendeeId": 2
    }
  }
}
```
</details>

- ### Watchlist Items
<details close>

<summary>Create New Watchlist Item</summary>
<br>
Request Body: <br>

```
  mutation {
    createWatchlistItem (
        tmdbId: 4608,
        userId: 1,
        mediaType: "tv"
    )
    {
        id
        tmdbId
        userId
    }
}
```

JSON Response Example: 
```json 
  {
  "data": {
    "createWatchlistItem": {
      "id": "83",
      "tmdbId": 4608,
      "userId": 1
    }
  }
}
```
</details>

<details close>

<summary>Delete Watchlist Item</summary>
<br>
Request Body: <br>

```
  mutation {
    deleteWatchlistItem (
        id: 83 )
    {
        id
    }
}
```

JSON Response Example: 
```json 
  {
  "data": {
    "deleteWatchlistItem": {
      "id": "83"
    }
  }
}
```
</details>


## Schema


## Gems
- [pry](https://github.com/pry/pry)
- [rspec-rails](https://github.com/rspec/rspec-rails)
- [capybara](https://github.com/teamcapybara/capybara)
- [simplecov](https://github.com/simplecov-ruby/simplecov)
- [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
- [jsonapi-serializer](https://github.com/jsonapi-serializer/jsonapi-serializer)




## Known Issues/Future Goals
Future features could include:
- Ability to add other users as friends.
- Ability to leave individual reviews on shows/movies.
- Additional recommendations based on popularity or at random.


