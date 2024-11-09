class AlgorithmCategory < ApplicationRecord
  include Sluggable

  has_many :algorithm_types, dependent: :destroy
  has_many :algorithms, through: :algorithm_types

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  scope :active, -> { where(active: true) }
  scope :ordered, -> { order(display_order: :asc) }
end
