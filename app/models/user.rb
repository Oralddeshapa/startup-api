class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable
  has_many :ideas, dependent: :destroy
  enum role: [:creator, :investor, :admin, :temporary_role]
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
