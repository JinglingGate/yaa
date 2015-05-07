require 'rails_helper'

RSpec.describe ApiController do
  describe 'POST delegate signup' do
    it 'creates a user session' do
      post :delegate, {format:'json', task:'signup', firstName:'Charlene', lastName:'Estiva', email:'example@gmail.com', username:'cestiva', password:'test123', passwordConfirmation:'test123'}
      user = User.find_by_username('cestiva')

      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe 'POST delegate login' do
    it 'creates a user session' do
      User.create(first_name:'Charlene', last_name:'Estiva', email:'example@gmail.com', username:'cestiva', password:'test123', password_confirmation:'test123')
      post :delegate, {format:'json', task: 'login', username:'cestiva', password:'test123'}
      user = User.find_by_username('cestiva')

      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe 'GET delegate logout' do
    it 'destroys a signed in users session' do
      user = User.create(first_name:'Charlene', last_name:'Estiva', email:'example@gmail.com', username:'cestiva', password:'test123', password_confirmation:'test123')
      post :delegate, {format:'json', task: 'login', username:'cestiva', password:'test123'}
      user = User.find_by_username('cestiva')

      get :delegate, {format:'json', task:'logout', userId: user.id} 
      
      expect(session[:user_id]).to eq(nil)
    end
  end
end
