class Admin::ResourcesController < Comfy::Admin::Cms::BaseController
  def resource_form
    @resource_types = ResourceType.pluck(:id, :name)
    render layout: false
  end

  def destroy
    resource = Resource.find(params[:id])
    resource.destroy

    resource.page.resources.order(:index).each_with_index do |resource, i|
      resource.index = i + 1
      resource.save
    end

    redirect_to :back, notice: "Resource deleted"
  end
end
