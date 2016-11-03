class Admin::MeasController < Comfy::Admin::Cms::BaseController
  def index
    @meas = Mea.order(:name).all
  end

  def new
    @mea = Mea.new
    @mea.mea_targets.build
  end

  def create
    @mea = Mea.create(mea_params)
    redirect_to action: :index, flash: {notice: "MEA was created"}
  end

  def edit
    @mea = Mea.find(params[:id])
  end

  def update
    @mea = Mea.find(params[:id])
    @mea.update(mea_params)

    redirect_to action: :index
  end

  def destroy
    @mea = Mea.find(params[:id])
    @mea.destroy

    redirect_to action: :index, flash: {notice: "MEA was deleted"}
  end

  def delete_target
    target = MeaTarget.find(params[:target_id])
    target.destroy

    redirect_to :back
  end

  private

  def mea_params
    params.require(:mea).permit(
      :name, :description, :logo,
      mea_targets_attributes: [:id, :target_number, :name, :description, :logo]
    )
  end
end


