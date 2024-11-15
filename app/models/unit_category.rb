class UnitCategory < ApplicationRecord
  has_many :units, dependent: :destroy

  validates :name, presence: true
  validates :slug, uniqueness: true, allow_nil: true

  before_validation :generate_slug

  private

  def generate_slug
    self.slug ||= name.parameterize
  end
end
