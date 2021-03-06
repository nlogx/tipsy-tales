class DosesController < ApplicationController
  before_action :set_cocktail

  def new
    @dose = authorize Dose.new(cocktail_id: @cocktail.id)
  end

  def create
    @dose = authorize Dose.new(dose_params)
    @dose.cocktail = @cocktail
    # @ingredient = Ingredient.find(dose_params[:ingredient_id])
    # @dose.ingredient = @ingredient unless @ingredient

    if @dose.save
      redirect_to @cocktail
    else
      render :new
    end
  end

  def destroy
    @dose = authorize Dose.find(params[:id])
    @dose.destroy
    redirect_to @cocktail
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id, :cocktail_id)
  end
end
