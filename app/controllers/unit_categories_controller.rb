class UnitCategoriesController < ApplicationController
  def index
    @unit_categories = UnitCategory.includes(:units)
                                 .order(:display_order)
                                 .page(params[:page])
  end

  def show
    @unit_category = UnitCategory.includes(units: :unit_comparisons)
                                .find_by!(slug: params[:slug])
    @units = @unit_category.units
                          .order(:display_order)
                          .page(params[:page])
  end
end
