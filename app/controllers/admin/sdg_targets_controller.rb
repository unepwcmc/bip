class Admin::SdgTargetsController < Comfy::Admin::Cms::BaseController
  def index
    @sdg_targets = Sdg::Target.includes(:sdg_goal).order("sdg_targets.target_number ASC").all
  end

  def new
    @sdg_target = Sdg::Target.new
  end

  def create
    @sdg_target = Sdg::Target.create(sdg_target_params)
    redirect_to action: :index, flash: {notice: "SDG target was created"}
  end

  def edit
    @sdg_target = Sdg::Target.find(params[:id])
  end

  def update
    @sdg_target = Sdg::Target.find(params[:id])
    @sdg_target.update(sdg_target_params)

    redirect_to action: :index
  end

  def destroy
    @sdg_target = Sdg::Target.find(params[:id])
    @sdg_target.destroy

    redirect_to action: :index, flash: {notice: "SDG target was deleted"}
  end

  private

  def sdg_target_params
    params.require(:sdg_target).permit(:target_number, :name, :description, :sdg_goal_id, :logo)
  end
end


