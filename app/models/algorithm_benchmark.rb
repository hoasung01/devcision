class AlgorithmBenchmark < ApplicationRecord
  belongs_to :algorithm_implementation

  validates :input_size, presence: true
  validates :input_type, presence: true
  validates :execution_time, presence: true

  scope :by_input_size, ->(size) { where(input_size: size) }
  scope :by_input_type, ->(type) { where(input_type: type) }
end
