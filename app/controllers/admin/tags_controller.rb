class Admin::TagsController < Comfy::Admin::Cms::BaseController
  def index
    @tags = Tag.order(:name).all
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    @tag.update(tag_params)

    redirect_to action: :index
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    redirect_to action: :index, flash: {notice: "Tag was deleted"}
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
