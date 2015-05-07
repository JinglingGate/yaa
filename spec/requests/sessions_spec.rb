require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /login" do
    it "returns login page" do
      get login_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /login" do
    user1 =  User.create(first_name: 'charlene', last_name: 'estiva', email: 'charlene@test.com', username: 'cbestiva', password: 'test123', password_confirmation: 'test123')

    it "redirect to root url" do
      post '/login', {username: 'cestiva', password: 'test123'}
      expect(response.status).to be(200)
      
      puts response.location
      puts "hihihihihi"
    end
  end
end
