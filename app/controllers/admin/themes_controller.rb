class Admin::ThemesController < Comfy::Admin::Cms::BaseController
  def index
    @themes = Theme.order(:name).all
  end

  def new
    @theme = Theme.new
  end

  def create
    @theme = Theme.create(theme_params)
    redirect_to action: :index, flash: {notice: "Theme was created"}
  end

  def edit
    @theme = Theme.find(params[:id])
  end

  def update
    @theme = Theme.find(params[:id])
    @theme.update(theme_params)

    redirect_to action: :index
  end

  def destroy
    @theme = Theme.find(params[:id])
    @theme.destroy

    redirect_to action: :index, flash: {notice: "Theme was deleted"}
  end

  private

  def theme_params
    params.require(:theme).permit(:name, :description, :logo)
  end
end
