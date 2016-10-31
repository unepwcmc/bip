class Admin::DisaggregationsController < Comfy::Admin::Cms::BaseController
  def destroy
    disaggregation = Disaggregation.find(params[:id])
    disaggregation.destroy

    redirect_to :back, notice: "Link disaggregation deleted"
  end
end
