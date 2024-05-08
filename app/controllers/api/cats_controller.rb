class Api::CatsController < ApplicationController
  before_action :client

  def random_cat_image
    response = client.random_cat_image(params[:num].to_i.nonzero?)
    if response[:status] == 200
      render json: response[:body]
    else
      render json: { error: 'Failed to fetch cat images' }, status: :internal_server_error
    end
  end

  def find_cat_image_by_id
    response = client.find_cat_image_by_id(params[:id])

    if response.nil? || response[:status] != 200
      render json: { error: 'Failed to fetch cat image' }, status: :internal_server_error
    else
      render json: response[:body]
    end
  end

  private

  def client
    client ||= CatsApi::V1::Client.new
  end
end
