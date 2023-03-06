<div align="center">
  <h1>Take-Home API</h1>
</div>

## Table of Contents
- [Project Overview](#project-overview)
- [Schema](#schema)
- [Setup](#setup)
- [Endpoints](#endpoints)
- [Gems](#gems)


## Project Overview
This API was built over the course of several days (8 hours total) as practice for completing take-home technical challenges found in interviews. The objective of this challenge was to create an API and relational database with three endpoints:

- "An endpoint to subscribe a customer to a tea subscription"
- "An endpoint to cancel a customer’s tea subscription"
- "An endpoint to see all of a customer’s subsciptions (active and cancelled)"

The tables and their attributes are based off of the guidelines given in the project specifications found [HERE](https://mod4.turing.edu/projects/take_home/take_home_be). All data is fictional for the purpose of this API.

## Schema



## Setup
This application uses Ruby 2.7.2 and Rails 5.2.8.1

1. Clone the repository (SSH: git@github.com:MadelineMauser/take-home.git)
2. Navigate into the root directory
3. Install gem packages: `bundle install`
4. Setup the database: `rails db:{drop,create,migrate,seed}`
6. Run `rails s` to start the server
7. You may run the RSpec test suite locally with `bundle exec rspec`

## Endpoints
This API was created with REST in mind.

### Create New Subscription
<details close>
<summary>This endpoint takes parameters passed through the request body in order to create a new tea subscription for a given customer. Associations between the new subscription and teas are created based on the IDs in the `tea_ids` array.</summary>
<br>
Request: ```POST '/api/v1/customers/{customer_id}/subscriptions'```
<br>
Request Body:
<br>

```json
{ 
  "subscription": {
    "title": "Chai Two",
    "price": "20",
    "frequency": "3"
  },
  "tea_ids": ["1", "2"]
}
```
  
JSON Response Example: 
``` json
  {
    "data": {
        "id": "5",
        "type": "subscription",
        "attributes": {
            "title": "Chai Two",
            "price": 20,
            "status": "active",
            "frequency": 3,
            "customer_id": 1,
            "teas": [
                {
                    "id": 1,
                    "title": "Spicy Chai",
                    "description": "Extra spicy with cinnamon.",
                    "temperature": 212,
                    "brew_time": 4,
                    "created_at": "2023-03-06T19:40:39.962Z",
                    "updated_at": "2023-03-06T19:40:39.962Z"
                },
                {
                    "id": 2,
                    "title": "Uncommon Chai",
                    "description": "Uses a secret blend of spices.",
                    "temperature": 200,
                    "brew_time": 3,
                    "created_at": "2023-03-06T19:40:39.966Z",
                    "updated_at": "2023-03-06T19:40:39.966Z"
                }
            ],
            "created_at": "2023-03-06T20:44:41.687Z",
            "updated_at": "2023-03-06T20:44:41.687Z"
        }
    }
}
```
</details>

### Cancel Subscription
<details close>
<summary>Calling this endpoints updates the provided subscription's status attribute to 'cancelled.' No records are deleted.</summary>
<br>

Request: ```PATCH 'api/v1/subscriptions/{subscription_id}/cancel'```
<br>

JSON Response on Success: 
```json 
{
    "message": "Subscription cancelled"
}
```
</details>

### View All Subscriptions Belonging to a Customer
<details close>

<summary>Querying this endpoint will return all subscriptions of the specified customer, including cancelled subscriptions. The subscription attributes contain an array that provides all associated teas.</summary>
<br>
Request: ```GET 'api/v1/customers/{customer_id}/subscriptions'```
<br>

JSON Response Example: 
```json 
  {
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "title": "Chai Delight",
                "price": 20,
                "status": "active",
                "frequency": 3,
                "customer_id": 1,
                "teas": [
                    {
                        "id": 1,
                        "title": "Spicy Chai",
                        "description": "Extra spicy with cinnamon.",
                        "temperature": 212,
                        "brew_time": 4,
                        "created_at": "2023-03-06T19:40:39.962Z",
                        "updated_at": "2023-03-06T19:40:39.962Z"
                    },
                    {
                        "id": 2,
                        "title": "Uncommon Chai",
                        "description": "Uses a secret blend of spices.",
                        "temperature": 200,
                        "brew_time": 3,
                        "created_at": "2023-03-06T19:40:39.966Z",
                        "updated_at": "2023-03-06T19:40:39.966Z"
                    }
                ],
                "created_at": "2023-03-06T19:40:39.986Z",
                "updated_at": "2023-03-06T19:40:39.986Z"
            }
        },
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "title": "Dawn Risers",
                "price": 20,
                "status": "cancelled",
                "frequency": 3,
                "customer_id": 1,
                "teas": [
                    {
                        "id": 3,
                        "title": "Morning Black",
                        "description": "Black tea with high caffeine.",
                        "temperature": 212,
                        "brew_time": 4,
                        "created_at": "2023-03-06T19:40:39.968Z",
                        "updated_at": "2023-03-06T19:40:39.968Z"
                    },
                    {
                        "id": 4,
                        "title": "English Breakfast",
                        "description": "Classic breakfast tea.",
                        "temperature": 200,
                        "brew_time": 3,
                        "created_at": "2023-03-06T19:40:39.969Z",
                        "updated_at": "2023-03-06T19:40:39.969Z"
                    }
                ],
                "created_at": "2023-03-06T19:40:40.000Z",
                "updated_at": "2023-03-06T19:40:40.000Z"
            }
        }
    ]
}
```
</details>

## Gems
- [pry](https://github.com/pry/pry)
- [rspec-rails](https://github.com/rspec/rspec-rails)
- [capybara](https://github.com/teamcapybara/capybara)
- [simplecov](https://github.com/simplecov-ruby/simplecov)
- [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
- [jsonapi-serializer](https://github.com/jsonapi-serializer/jsonapi-serializer)

## Known Issues/Future Goals
Future features could include:
- More robust testing
- Ability to view and manage customers



