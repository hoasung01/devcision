class AlgorithmCategoriesController < ApplicationController
  def show
    # Find the category by its slug
    @category = AlgorithmCategory.includes(:algorithm_types)
                                 .find_by!(slug: params[:slug])

    # Fetch all algorithms associated with this category and paginate them
    @algorithms = @category.algorithms
                           .includes(:complexities, :algorithm_type)
                           .order(:difficulty_level)
                           .page(params[:page]).per(10)
  end
end
