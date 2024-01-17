# README

## Project Learning Goals

 - Learning Goals
 - Expose an API that aggregates data from multiple external APIs
 - Expose an API that requires an authentication token
 - Expose an API for CRUD functionality
 - Determine completion criteria based on the needs of other developers
 - Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).


### Prerequisites

Rails 7.1.2

### Installation

1. Get a free Weather API Key at [https://www.weatherapi.com/](https://www.weatherapi.com/)

2. Get a free MapQuest API Key at [https://developer.mapquest.com/](https://developer.mapquest.com)

3. Clone the repo
   ```sh
   git clone https://github.com/mbkuhl/sweater_weather
   ```
4. Enter your API
  Terminal
   ```sh
   EDITOR="code --wait" rails credentials:edit
   ```
  In editor pop up - ensure proper indentation
  ```ruby
  weather_api:
    key: <YOUR WEATHER API KEY>

  mapquest_api:
    key: <YOUR MAPQUEST API KEY>
  ```
5. Gem Installation
   ```sh
    bundle install
   ```
6. Database reset
   ```sh
    rails db:{drop,create,migrate,seed}
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Running Tests

1. Run all tests
   ```sh
    bundle exec rspec
   ```

2. Groups of tests can be run by specifying folders and files
   ```sh
    bundle exec rspec spec/requests
   ```

3. Specific tests can be run by specifying lines within files
   ```sh
    bundle exec rspec spec/requests/api/v0/road_trips/show_spec.rb:15
   ```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Endpoint Usage

1. Start the local host server
   ```sh
   rails s
   ```

2. Call the api using the root address

    ```ruby
    http://localhost:3000
    ```
### Endpoints

  1. ```get api/v0/forecast```

Call API using query param location to retrieve various weather stats of that area for the next 5 days. Ex:

```ruby
post http://localhost:3000/api/v0/forecast?location=houston,tx 
```

  2. ```post api/v0/users ```

Call API using JSON payload in body to send password, email, and password confirmation. API key will be generated and returned. Ex:

```ruby
post http://localhost:3000/api/v0/users
```

Body
```
{
  "email": "whatever1@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

  3. ```post api/v0/sessions ```

   Call API using JSON payload in body to send email and password. User email and API key will be returned. Ex:

```ruby
post http://localhost:3000/api/v0/sessions
```

Body
```
{
  "email": "whatever1@example.com",
  "password": "password",
}
```

  4. ```post api/v0/road_trip```

     Call API using JSON payload in body to send API key, origin, and destination. Travel time and weather at the destination at the time of ETA will be returned. Ex:

```ruby
post http://localhost:3000/api/v0/road_trip
```

Body
```
{
  "origin": "Cincinatti, OH",
  "destination": "Chicago, IL",
  "api_key": "BGoAvQ1hXA4Olhgzzx9gSw"
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>