class Idea < ApplicationRecord
  validates :title, presence: true
  validates :problem, presence: true
  enum field: [:science, :economy, :politics, :food, :service, :transport] #6
  enum region: [:EU, :RU, :ZA, :NA, :SA, :AU, :CN, :JP] #8
  belongs_to :user
  has_many :comments
  has_many :ratings
  has_many :views
  has_many :interests
end
