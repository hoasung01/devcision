class AlgorithmCategory < ApplicationRecord
  has_many :algorithm_types, dependent: :destroy
  has_many :algorithms, through: :algorithm_types

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug

  scope :active, -> { where(active: true) }
  scope :ordered, -> { order(display_order: :asc) }

  private

  def generate_slug
    self.slug ||= name.parameterize
  end
end
