# frozen_string_literal: true

require 'faraday'

class CatsApi::V1::Client
  BASE_URL = 'https://api.thecatapi.com/v1/images'
  API_KEY = Rails.application.credentials.cats_api_key

  def random_cat_image
    request(
      http_method: :get,
      endpoint: 'search'
    )
  end

  def multiple_cat_images(num = '')
    request(
      http_method: :get,
      endpoint: 'search',
      params: { limit: num.to_int }
    )
  end

  def find_cat_image_by_id(id)
    request(
      http_method: :get,
      endpoint: id.to_s
    )
  end

  private

  def client
    @client ||= begin
      options = {
        request: {
          open_timeout: 10,
          read_timeout: 10
        }
      }
      Faraday.new(url: BASE_URL, **options) do |config|
        config.headers['x-api-key'] = API_KEY # add API key to headers
        config.request :json
        config.response :json, parser_options: { symbolize_names: true }
        config.response :raise_error
        config.response :logger, Rails.logger, headers: true, bodies: true, log_level: :debug
      end
    end
  end

  def request(http_method:, endpoint:, params: {}, body: {})
    response = client.public_send(http_method, endpoint, params, body)
    {
      status: response.status,
      body: response.body
    }
  rescue Faraday::Error => e
    puts e.inspect
  end
end
