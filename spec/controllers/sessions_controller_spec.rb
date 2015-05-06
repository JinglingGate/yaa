require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  context 'with valid credentials' do
    user1 =  User.create(first_name: 'charlene', last_name: 'estiva', email: 'charlene@test.com', username: 'cbestiva', password: 'test123', password_confirmation: 'test123')
    
    let :credentials do
      {username: 'cbestiva', password: 'test123'}
    end
    
    before :each do 
      post :create, credentials
    end

    describe '#create' do
      it 'creates a user session' do
        puts user1.errors.full_messages
        expect(session[:user_id]).to_not be_nil
        expect(session[:user_id]).to be(user1.id)
      end
    end

    describe '#destroy' do
      context 'when user is logged in' do
        before :each do
          get :destroy, {}, {user_id: user1.id}
        end
        
        it 'should clear the session' do
          expect(session[:user_id]).to be_nil
        end
      end
    end
  end
end
