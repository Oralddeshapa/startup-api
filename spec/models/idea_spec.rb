require 'rails_helper'

RSpec.describe Idea, type: :model do

  let (:user) { create(:user) }

  describe 'vailidations' do
    it 'ensures title is present' do
      idea = Idea.new(problem: 'tester', rating: 4, field: 'science', region: 'RU')
      expect(idea).not_to be_valid
    end

    it 'ensures problem is present' do
      idea = Idea.new(title: 'testing', rating: 4, field: 'science', region: 'RU')
      expect(idea).not_to be_valid
    end

    it 'ensures rating is present' do
      idea = Idea.new(title: 'testing', problem: 'tester', field: 'science', region: 'RU')
      expect(idea).not_to be_valid
    end

    it 'saves idea with correct fields' do
      idea = Idea.new(title: 'testing', problem: 'tester', rating: 4, field: 'science', region: 'RU', user_id: user.id)
      expect(idea).to be_valid
    end
  end
end
