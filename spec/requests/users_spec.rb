require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    #it "works! (now write some real specs)" do
    #  get users_path
    #  expect(response).to have_http_status(200)
    it "returns list of all users" do
      user1 = User.create(first_name: 'charlene', last_name: 'estiva', email: 'charlene@test.com', username: 'cbestiva', password: 'test123', password_confirmation: 'test123')
      user2 = User.create(first_name: 'andrew', last_name: 'warring', email: 'andrew@test.com', username: 'awarring', password: 'test123', password_confirmation: 'test123')
      visit users_path
      puts page.status_code
      expect(page).to have_http_status(200)
      #puts page.body
      #expect(page).to have_content(user1.to_json)
    end
  end
end
