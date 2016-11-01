class Admin::AichiTargetsController < Comfy::Admin::Cms::BaseController
  def index
    @aichi_targets = Aichi::Target.includes(:aichi_goal).order("aichi_targets.target_number ASC").all
  end

  def new
    @aichi_target = Aichi::Target.new
  end

  def create
    @aichi_target = Aichi::Target.create(aichi_target_params)
    redirect_to action: :index, flash: {notice: "Aichi target was created"}
  end

  def edit
    @aichi_target = Aichi::Target.find(params[:id])
  end

  def update
    @aichi_target = Aichi::Target.find(params[:id])
    @aichi_target.update(aichi_target_params)

    redirect_to action: :index
  end

  def destroy
    @aichi_target = Aichi::Target.find(params[:id])
    @aichi_target.destroy

    redirect_to action: :index, flash: {notice: "Aichi target was deleted"}
  end

  private

  def aichi_target_params
    params.require(:aichi_target).permit(:target_number, :name, :description, :aichi_goal_id, :logo)
  end
end


