class AlgorithmsController < ApplicationController
  def show
    # Find the algorithm by its slug
    @algorithm = Algorithm.includes(:complexities, :algorithm_type)
                          .find_by!(slug: params[:slug])

    # If the algorithm is not found, redirect to root or show a 404 error
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "Algorithm not found"
  end
end
