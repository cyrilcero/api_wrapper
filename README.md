# CAT Images API Client

#### The Cats API Client is a Ruby client for interacting with the Cats API. It provides methods for accessing various endpoints of the Cats API, such as retrieving random cat images and finding cat images by ID. 

#### The Cats API Client internally uses the **Faraday gem** for making HTTP requests to **thecatsapi.com**.


## Installation
To use the Cats API Client in your Ruby application, add it to your Gemfile:

```ruby
gem 'cats_api_client', git: 'https://github.com/your_username/cats_api_client.git'
```
Then, run bundle install to install the gem.

## Usage

### Configuration
Before using the Cats API Client, make sure to configure it with your API key. You can do this in an initializer or directly in your code:

```ruby
CatsApi::Client.configure do |config|
  config.api_key = Rails.application.credentials.cats_api_key
end
```

## Basic Usage

```ruby
# Initialize the client
client = CatsApi::Client.new

# Get a random cat image
response = client.random_cat_image
puts response[:body]

# Get 5 random cat images
response = client.random_cat_image(5)
puts response[:body]

# Find a cat image by ID
response = client.find_cat_image_by_id('your_image_id')
puts response[:body]
```

## Contributing
Contributions are welcome! Please feel free to submit a pull request or open an issue if you find any bugs or want to suggest improvements. 