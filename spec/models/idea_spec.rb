require 'rails_helper'

RSpec.describe Idea, type: :model do
  context 'vailidation tests' do
    it 'ensures title is present' do
      idea = Idea.new(problem: 'tester', rating: 4, field: 'science', region: 'RU').save
      expect(idea).to eq(false)
    end

    it 'ensures problem is present' do
      idea = Idea.new(title: 'testing', rating: 4, field: 'science', region: 'RU').save
      expect(idea).to eq(false)
    end

    it 'ensures rating is present' do
      idea = Idea.new(title: 'testing', problem: 'tester', field: 'science', region: 'RU').save
      expect(idea).to eq(false)
    end

    it 'saves idea with correct fields' do
      idea = Idea.new(title: 'testing', problem: 'tester', rating: 4, field: 'science', region: 'RU').save
      expect(idea).to eq(false)
    end
  end
end
