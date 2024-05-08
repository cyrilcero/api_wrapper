require 'test_helper'

class CatsControllerTest < ActionDispatch::IntegrationTest
  test 'should get random_cat_image with limit' do
    get '/api/cats/random', params: { limit: 5 }
    assert_response :success
  end

  test 'should get random_cat_image without limit' do
    get '/api/cats/random'
    assert_response :success
  end

  test 'should get find_cat_image_by_id' do
    get '/api/cats/ap8'
    assert_response :success
  end
end
