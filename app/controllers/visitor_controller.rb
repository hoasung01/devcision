class VisitorController < ApplicationController
  def index
    # Get main algorithm categories with their types, paginated
    @algorithm_categories = AlgorithmCategory.includes(:algorithm_types)
                                              .order(:display_order)
                                              .page(params[:page]).per(20)

    # Group algorithms by categories, paginate the query results for each category
    @categorized_algorithms = {
      sorting: fetch_algorithms_by_category('Sorting Algorithms').page(params[:page]).per(6),
      searching: fetch_algorithms_by_category('Searching Algorithms').page(params[:page]).per(6),
      graph: fetch_algorithms_by_category('Graph Algorithms').page(params[:page]).per(6),
      dynamic: fetch_algorithms_by_category('Dynamic Programming').page(params[:page]).per(6),
      string: fetch_algorithms_by_category('String Algorithms').page(params[:page]).per(6),
      tree: fetch_algorithms_by_category('Tree Algorithms').page(params[:page]).per(6),
      greedy: fetch_algorithms_by_category('Greedy Algorithms').page(params[:page]).per(6),
      backtracking: fetch_algorithms_by_category('Backtracking Algorithms').page(params[:page]).per(6)
    }
  end

  def show
    # Check if the slug is present in the params
    if params[:slug].blank?
      redirect_to root_path, alert: "Category not found" and return
    end

    # Find the category by slug or show an error if not found
    @category = AlgorithmCategory.includes(:algorithm_types).find_by(slug: params[:slug])

    # If the category is not found, show a 404 error
    if @category.nil?
      redirect_to root_path, alert: "Category not found" and return
    end

    # Paginate the algorithms for this category
    @algorithms = @category.algorithms
                           .includes(:complexities, :algorithm_type)
                           .order(:difficulty_level)
                           .page(params[:page]).per(10)
  end

  def analyze_problem
    return unless request.post?

    begin
      analyzer = Ai::AlgorithmAnalyzerService.new
      @analysis = analyzer.analyze_requirements(params[:description])
      @suggestions = analyzer.suggest_algorithm(@analysis)

      render json: {
        success: true,
        analysis: @analysis,
        suggestions: @suggestions
      }
    rescue => e
      Rails.logger.error("AI Analysis Error: #{e.message}")
      render json: {
        success: false,
        error: "Analysis failed: #{e.message}"
      }, status: :internal_server_error
    end
  end

  private

  def fetch_algorithms_by_category(category_name)
    Algorithm.includes(:algorithm_type, :complexities)
            .joins(algorithm_type: :algorithm_category)
            .where(algorithm_categories: { name: category_name })
            .order(:difficulty_level)
  end
end
