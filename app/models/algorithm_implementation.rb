class AlgorithmImplementation < ApplicationRecord
  belongs_to :algorithm
  has_many :algorithm_benchmarks, dependent: :destroy

  validates :language, presence: true
  validates :code, presence: true
  validates :language, uniqueness: { scope: :algorithm_id }

  scope :verified, -> { where(verified: true) }
  scope :by_language, ->(lang) { where(language: lang) }

  def run_tests
    TestRunnerService.new(self).execute
  end

  def benchmark(input_size: 1000, input_type: 'random')
    BenchmarkService.new(self, input_size: input_size, input_type: input_type).run
  end
end
