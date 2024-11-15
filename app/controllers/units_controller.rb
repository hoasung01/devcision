class UnitsController < ApplicationController
  def index
    @unit_category = UnitCategory.find_by!(slug: params[:unit_category_slug])
    @units = @unit_category.units
                          .includes(:unit_comparisons)
                          .order(:display_order)
                          .page(params[:page])
  end

  def show
    @unit = Unit.includes(:unit_comparisons, :unit_category)
                .find(params[:id])
    @comparisons = @unit.unit_comparisons
                       .order(:comparison_type, :value)
    @conversions = UnitConversion.where(from_unit: @unit)
                                .or(UnitConversion.where(to_unit: @unit))
                                .includes(:from_unit, :to_unit)
  end

  def convert
    @from_unit = Unit.find_by!(slug: params[:from_unit])
    @to_unit = Unit.find_by!(slug: params[:to_unit])
    @value = params[:value].to_f

    conversion = UnitConversion.find_by(from_unit: @from_unit, to_unit: @to_unit)
    @converted_value = conversion&.convert(@value)

    @comparisons = @to_unit.unit_comparisons
                          .where('value <= ?', @converted_value)
                          .order(value: :desc)
                          .limit(5)

    respond_to do |format|
      format.html
      format.json { render json: {
        value: @converted_value,
        unit: @to_unit.symbol,
        comparisons: @comparisons.map { |c| {
          title: c.title,
          description: c.description,
          value: c.value
        }}
      }}
    end
  end
end
