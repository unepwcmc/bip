class Admin::SdgGoalsController < Comfy::Admin::Cms::BaseController
  def index
    @sdg_goals = Sdg::Goal.order(:position).all
  end

  def new
    @sdg_goal = Sdg::Goal.new
  end

  def create
    @sdg_goal = Sdg::Goal.create(sdg_goal_params)
    redirect_to action: :index, flash: {notice: "SDG goal was created"}
  end

  def edit
    @sdg_goal = Sdg::Goal.find(params[:id])
  end

  def update
    @sdg_goal = Sdg::Goal.find(params[:id])
    @sdg_goal.update(sdg_goal_params)

    redirect_to action: :index
  end

  def destroy
    @sdg_goal = Sdg::Goal.find(params[:id])
    @sdg_goal.destroy

    redirect_to action: :index, flash: {notice: "SDG goal was deleted"}
  end

  private

  def sdg_goal_params
    params.require(:sdg_goal).permit(:name, :description, :position, :logo)
  end
end


