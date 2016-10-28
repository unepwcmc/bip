class Admin::ResourcesController < Comfy::Admin::Cms::BaseController
  def destroy
    resource = Resource.find(params[:id])
    resource.destroy

    redirect_to :back, notice: "Resource deleted"
  end
end
