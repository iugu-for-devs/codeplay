require 'rails_helper'

describe 'User', type: :request do
  it 'can view specific navbar when logged in and acessing the correct url' do
    client = Fabricate(:user)
    login_as client, scope: :user

    get "/user/#{client.id}"

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(client.email)
  end

  it 'are redirected to home when try to access another user url' do
    client = Fabricate.times(3, :user)
    login_as client[0], scope: :user

    get "/user/#{client[1].id}"

    expect(response).to have_http_status(302)
    expect(response.body).to include('redirected')
    expect(response).to redirect_to(root_path)
  end
end
