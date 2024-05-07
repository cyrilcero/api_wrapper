# frozen_string_literal: true

require 'faraday'

class CatsApi::V1::Client
  BASE_URL = 'https://api.thecatapi.com/v1/images'
  API_KEY = Rails.application.credentials.cats_api_key

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
        config.request :authorization, 'x-api-key', API_KEY
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
