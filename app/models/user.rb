class User < ApplicationRecord
  has_many :ideas, dependent: :destroy
  has_many :comments
  has_many :ratings
  has_many :views
  has_many :interests
  enum role: [:creator, :investor, :admin]
  validates :email,
    length: { minimum: 8, maximum: 40 }
  validates :username,
    length: { minimum: 3, maximum: 20 }
  validates :role,
    length: { minimum: 3 }
  validates :password,
    length: { minimum: 3, maximum: 40 }
  scope :investors, -> { where(role: 'investor') }
  scope :creators,-> { where(role: 'creator') }
end
