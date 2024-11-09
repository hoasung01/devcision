class AlgorithmComplexity < ApplicationRecord
  belongs_to :algorithm

  validates :operation_type, presence: true
  validates :operation_type, uniqueness: { scope: :algorithm_id }

  def full_analysis
    {
      operation: operation_type,
      complexities: {
        best: best_case,
        average: average_case,
        worst: worst_case
      },
      explanation: explanation
    }
  end
end
