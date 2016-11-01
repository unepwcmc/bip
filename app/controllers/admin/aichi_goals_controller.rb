class Admin::AichiGoalsController < Comfy::Admin::Cms::BaseController
  def index
    @aichi_goals = Aichi::Goal.order(:name).all
  end

  def new
    @aichi_goal = Aichi::Goal.new
  end

  def create
    @aichi_goal = Aichi::Goal.create(aichi_goal_params)
    redirect_to action: :index, flash: {notice: "Aichi goal was created"}
  end

  def edit
    @aichi_goal = Aichi::Goal.find(params[:id])
  end

  def update
    @aichi_goal = Aichi::Goal.find(params[:id])
    @aichi_goal.update(aichi_goal_params)

    redirect_to action: :index
  end

  def destroy
    @aichi_goal = Aichi::Goal.find(params[:id])
    @aichi_goal.destroy

    redirect_to action: :index, flash: {notice: "Aichi goal was deleted"}
  end

  private

  def aichi_goal_params
    params.require(:aichi_goal).permit(:name, :description)
  end
end


