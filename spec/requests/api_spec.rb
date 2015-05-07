require 'rails_helper'

RSpec.describe "Api", type: :request do
  describe 'POST signup' do
    it 'creates a new user' do
      post '/api', {format:'json', task: 'signup', firstName: 'Charlene', lastName: 'Estiva', email: 'example@gmail.com', username: 'cestiva', password: 'test123', passwordConfirmation: 'test123'}
      user = User.find_by_username('cestiva')

      expected_json = {
        task: 'signup',
        status: 'success',
        userId: user.id,
        username: user.username
      }.to_json

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_json)
    end
    it 'does not create a user if any params are missing' do
      post '/api', {format:'json', task: 'signup'}

      expected_json = {
        task: 'signup',
        status: 'failure',
        message: {first_name:["can't be blank"], last_name:["can't be blank"], email:["can't be blank"], username:["can't be blank","is too short (minimum is 7 characters)"], password:["can't be blank","is too short (minimum is 7 characters)"], password_confirmation:["can't be blank"]}
      }.to_json

      expect(response.body).to eq(expected_json)
    end
    it 'does not create a user if password and password confirmation are missing' do
      post '/api', {format:'json', task: 'signup', firstName:'Charlene', lastName:'Estiva', email:'example@gmail.com', username:'cestiva'}
      
      expected_json = {
        task: 'signup',
        status: 'failure',
        message: {password:["can't be blank", "is too short (minimum is 7 characters)"], password_confirmation:["can't be blank"]}
      }.to_json

      expect(response.body).to eq(expected_json)
    end
  end
  
  describe 'POST login' do
    it 'creates a session' do
      User.create(first_name:'Charlene', last_name:'Estiva', email:'example@gmail.com', username:'cestiva', password:'test123', password_confirmation:'test123')
      post '/api', {format:'json', task:'login', username:'cestiva', password:'test123'}
      user = User.find_by_username('cestiva')

      expected_json = {
        task: 'login',
        status: 'success',
        userId: user.id,
        username: user.username
      }.to_json
     
      expect(response.body).to eq(expected_json)
    end
    it 'does not create a session with an invalid password' do
      User.create(first_name:'Charlene', last_name:'Estiva', email:'example@gmail.com', username:'cestiva', password:'test123', password_confirmation:'test123')
      post '/api', {format:'json', task:'login', username:'cestiva', password:'incorrect'}
      user = User.find_by_username('cestiva')

      expected_json = {
        task: 'login',
        status: 'failure',
        message: 'Incorrect password.'
      }.to_json

      expect(response.body).to eq(expected_json)
    end
  end

  describe 'GET logout' do
    it 'destroys a user session' do
      User.create(first_name:'Charlene', last_name:'Estiva', email:'example@gmail.com', username:'cestiva', password:'test123', password_confirmation:'test123')
      post '/api', {format:'json', task:'login', username:'cestiva', password:'test123'}      
      user = User.find_by_username('cestiva')
      
      get '/api', {format:'json', task: 'logout', userId: user.id}

      expected_json = {
        task: 'logout',
        status: 'success',
        userId: nil
      }.to_json

      expect(response.body).to eq(expected_json)
    end
  end

  describe 'POST pin' do
    it 'creates a pin  users location' do
    end 
  end
end
