class AlgorithmType < ApplicationRecord
  belongs_to :algorithm_category
  has_many :algorithms, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :name, uniqueness: { scope: :algorithm_category_id }

  before_validation :generate_slug

  scope :ordered, -> { order(display_order: :asc) }

  private

  def generate_slug
    self.slug ||= name.parameterize
  end
end
