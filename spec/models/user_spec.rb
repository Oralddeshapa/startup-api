require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'vailidations' do
    it 'ensures email is present & correct' do
      user = User.new(email: '123', username: 'tester', password: '123456', role: 'investor').valid?
      expect(user).to eq(false)
    end

    it 'ensures username is present & correct' do
      user = User.new(email: 'test_m@mail.ru', username: '0', password: '123456', role: 'investor').valid?
      expect(user).to eq(false)
    end

    it 'ensures role is present & correct' do
      user = User.new(email: 'test_m@mail.ru', username: 'tester', password: '123456').valid?
      expect(user).to eq(false)
    end

    it 'ensures password is present & correct' do
      user = User.new(email: 'test_m@mail.ru', username: 'tester', password: '1', role: 'investor').valid?
      expect(user).to eq(false)
    end

    it 'saves user with correct fields' do
      user = User.new(email: 'test@mail.ru', username: 'tester', password: '123456', role: 'investor').valid?
      expect(user).to eq(true)
    end
  end

  describe 'scopes' do
    before(:each) do
      create(:user, role: 'investor')
      create(:user, role: 'creator')
      create(:user, role: 'investor')
      create(:user, role: 'creator')
      create(:user, role: 'investor')
    end

    it 'should return number of investors' do
      expect(User.investors.size).to eq(3)
    end

    it 'should return number of creators' do
      expect(User.creators.size).to eq(2)
    end
  end
end
