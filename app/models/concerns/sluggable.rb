module Sluggable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_unique_slug, if: :name_changed?
  end

  private

  def generate_unique_slug
    return if slug.present?  # Return early if the slug is already set

    # Base components to create the slug (using the related category and type)
    base_components = []
    if respond_to?(:algorithm_type) && algorithm_type
      base_components << algorithm_type.algorithm_category.name.parameterize
      base_components << algorithm_type.name.parameterize
    end
    base_components << name.parameterize

    # Generate the base slug
    base_slug = base_components.join('-')

    # Ensure that the generated slug is unique across all models (Algorithm, AlgorithmType, AlgorithmCategory)
    self.slug = base_slug
    counter = 1
    while Algorithm.exists?(slug: slug) || AlgorithmType.exists?(slug: slug) || AlgorithmCategory.exists?(slug: slug)
      self.slug = "#{base_slug}-#{counter}"
      counter += 1
    end
  end
end
