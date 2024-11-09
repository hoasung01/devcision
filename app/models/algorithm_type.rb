class AlgorithmType < ApplicationRecord
  include Sluggable

  belongs_to :algorithm_category
  has_many :algorithms, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :name, uniqueness: { scope: :algorithm_category_id }

  scope :ordered, -> { order(display_order: :asc) }
end
