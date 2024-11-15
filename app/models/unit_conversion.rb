class UnitConversion < ApplicationRecord
  belongs_to :from_unit, class_name: 'Unit'
  belongs_to :to_unit, class_name: 'Unit'

  validates :conversion_factor, presence: true
  validates :from_unit_id, uniqueness: { scope: :to_unit_id }

  def convert(value)
    value * conversion_factor
  end
end
