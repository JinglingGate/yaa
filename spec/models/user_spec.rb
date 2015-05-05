require 'rails_helper'

#RSpec.describe User, type: :model do
#  pending "add some examples to (or delete) #{__FILE__}"
#end

RSpec.describe User do
  describe 'validations' do
    subject {User.new(first_name: 'charlene', last_name: 'estiva', email: 'charlene@test.com', username: 'cestiva', password: 'test123', password_confirmation: 'test123')}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:username)}
    it {should validate_length_of(:username).is_at_least(7)}
    it {should have_secure_password}
    it {should validate_length_of(:password).is_at_least(7)}
  end

  it 'has a capitalized first and last name' do 
    user = User.new(first_name: 'charlene', last_name: 'estiva', email: 'charlene@test.com', username: 'cestiva', password: 'test123', password_confirmation: 'test123')
    user.save
    expect(user.first_name).to eq('Charlene')
    expect(user.last_name).to eq('Estiva')
  end
end
