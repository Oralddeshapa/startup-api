class Idea < ApplicationRecord
  validates :title, presence: true
  enum field: [ :science, :economy, :politics, :food, :service, :transport ] #6
  enum region: [ :EU, :RU, :Africa, :NA, :SA, :Australia, :Asia, :Japan ] #8
end
