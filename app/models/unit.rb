class Unit < ApplicationRecord
  belongs_to :unit_category
  has_many :unit_comparisons, dependent: :destroy
  has_many :from_conversions, class_name: 'UnitConversion',
                             foreign_key: 'from_unit_id'
  has_many :to_conversions, class_name: 'UnitConversion',
                           foreign_key: 'to_unit_id'

  validates :name, :symbol, presence: true
  validates :symbol, uniqueness: { scope: :unit_category_id }

  def convert_to(target_unit, value)
    conversion = UnitConversion.find_by(from_unit: self, to_unit: target_unit)
    conversion&.convert(value)
  end
end
