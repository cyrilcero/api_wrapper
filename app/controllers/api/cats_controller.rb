class Api::CatsController < ApplicationController
  before_action :client

  def random_cat_image
    response = client.random_cat_image(params[:limit].to_i)
    if response[:status] == 200
      @cat_images = response[:body]
      render json: @cat_images
    else
      render json: { error: 'Failed to fetch cat images' }, status: :internal_server_error
    end
  end

  def find_cat_image_by_id
    response = client.find_cat_image_by_id(params[:id])

    if response[:status] == 200
      @cat_image = response[:body]
      render json: @cat_image
    else
      render json: { error: 'Failed to fetch cat image' }, status: :not_found
    end
  end

  private

  def client
    client ||= CatsApi::V1::Client.new
  end
end
