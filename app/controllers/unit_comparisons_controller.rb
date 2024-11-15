class UnitComparisonsController < ApplicationController
  def index
    @unit = Unit.find_by!(slug: params[:unit_slug])
    @comparisons = @unit.unit_comparisons
                       .order(:comparison_type, :value)
                       .page(params[:page])
  end
end
