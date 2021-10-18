class Idea < ApplicationRecord
  validates :title, presence: true
  validates :problem, presence: true
  enum field: [:science, :economy, :politics, :food, :service, :transport] #6
  enum region: [:EU, :RU, :ZA, :NA, :SA, :AU, :CN, :JP] #8
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :views, dependent: :destroy
  has_many :interests, dependent: :destroy

end
