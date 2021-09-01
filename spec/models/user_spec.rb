RSpec.describe User, type: :model do
  describe 'vailidations' do
    it 'ensures email is present & correct' do
      user = User.new(email: '123', username: 'tester', password: '123456', role: 'investor')
      expect(user).not_to be_valid
    end

    it 'ensures username is present & correct' do
      user = User.new(email: 'test_m@mail.ru', username: '0', password: '123456', role: 'investor')
      expect(user).not_to be_valid
    end

    it 'ensures role is present & correct' do
      user = User.new(email: 'test_m@mail.ru', username: 'tester', password: '123456')
      expect(user).not_to be_valid
    end

    it 'ensures password is present & correct' do
      user = User.new(email: 'test_m@mail.ru', username: 'tester', password: '1', role: 'investor')
      expect(user).not_to be_valid
    end

    it 'saves user with correct fields' do
      user = User.new(email: 'test@mail.ru', username: 'tester', password: '123456', role: 'investor')
      expect(user).to be_valid
    end
  end

  describe 'scopes' do
    before(:each) do
      create_list(:user, 3, role: 'investor')
      create_list(:user, 2, role: 'creator')
    end

    it 'should return number of investors' do
      expect(User.investors.size).to eq(3)
    end

    it 'should return number of creators' do
      expect(User.creators.size).to eq(2)
    end
  end
end
