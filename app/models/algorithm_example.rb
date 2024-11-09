class AlgorithmExample < ApplicationRecord
  belongs_to :algorithm

  validates :title, presence: true
  validates :description, presence: true

  scope :by_difficulty, ->(level) { where(difficulty_level: level) }
end
