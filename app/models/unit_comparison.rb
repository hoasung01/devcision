class UnitComparison < ApplicationRecord
  belongs_to :unit

  validates :title, :value, presence: true
  validates :comparison_type, inclusion: {
    in: ['Real-life', 'Technical', 'Historical']
  }

  scope :by_difficulty, ->(level) { where(difficulty_level: level) }
  scope :by_type, ->(type) { where(comparison_type: type) }
end
