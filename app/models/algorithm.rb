class Algorithm < ApplicationRecord
  belongs_to :algorithm_type
  has_many :implementations, class_name: 'AlgorithmImplementation', dependent: :destroy
  has_many :examples, class_name: 'AlgorithmExample', dependent: :destroy
  has_many :complexities, class_name: 'AlgorithmComplexity', dependent: :destroy
  has_many :benchmarks, through: :implementations, source: :algorithm_benchmarks

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :name, uniqueness: { scope: :algorithm_type_id }

  before_validation :generate_slug

  scope :by_difficulty, ->(level) { where(difficulty_level: level) }
  scope :stable_only, -> { where(stable: true) }
  scope :in_place_only, -> { where(in_place: true) }
  scope :recursive_only, -> { where(recursive: true) }
  scope :parallel_capable, -> { where(parallel_possible: true) }

  def complexity_analysis
    {
      time: {
        best: time_complexity_best,
        average: time_complexity_average,
        worst: time_complexity_worst
      },
      space: space_complexity,
      details: complexities.map(&:attributes),
      factors: complexity_factors
    }
  end

  def implementation_in(language)
    implementations.find_by(language: language)
  end

  def performance_comparison(input_size: 1000)
    benchmarks.where(input_size: input_size)
              .group_by(&:input_type)
  end

  private

  def generate_slug
    self.slug ||= name.parameterize
  end

  def complexity_factors
    factors = []
    factors << "recursive" if recursive
    factors << "in-place" if in_place
    factors << "stable" if stable
    factors << "parallel possible" if parallel_possible
    factors
  end
end
