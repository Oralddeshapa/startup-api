require 'rails_helper'

RSpec.describe User, type: :model do
  context 'vailidation tests' do
    it 'ensures email is present & correct' do
      user = User.new(email: '123', username: 'tester', password: '123456', role: 'investor').save
      expect(user).to eq(false)
    end

    it 'ensures username is present & correct' do
      user = User.new(email: 'test_m@mail.ru', username: '0', password: '123456', role: 'investor').save
      expect(user).to eq(false)
    end

    it 'ensures role is present & correct' do
      user = User.new(email: 'test_m@mail.ru', username: 'tester', password: '123456').save
      expect(user).to eq(false)
    end

    it 'ensures password is present & correct' do
      user = User.new(email: 'test_m@mail.ru', username: 'tester', password: '1', role: 'investor').save
      expect(user).to eq(false)
    end

    it 'saves user with correct fields' do
      user = User.new(email: 'test@mail.ru', username: 'tester', password: '123456', role: 'investor').save
      expect(user).to eq(true)
    end
  end

  context 'scope tests' do
    let! (:params) { { email: 'test_0@mail.ru', username: 'tester', password: '123456', role: 'investor' } }
    before(:each) do
      User.new(params).save
      User.new(params.merge({ role: 'creator', email: 'test_1@mail.ru' })).save
      User.new(params.merge(email: 'test_2@mail.ru')).save
      User.new(params.merge({ role: 'creator', email: 'test_3@mail.ru' })).save
      User.new(params.merge(email: 'test_4@mail.ru')).save
    end

    it 'should return number of investors' do
      kappa = User.investors
      expect(User.investors.size).to eq(3)
    end

    it 'should return number of creators' do
      expect(User.creators.size).to eq(2)
    end
  end
end
