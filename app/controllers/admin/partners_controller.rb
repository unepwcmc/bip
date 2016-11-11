class Admin::PartnersController < Comfy::Admin::Cms::BaseController
  def index
    @partners = Partner.order(:name).all
  end

  def new
    @partner = Partner.new
  end

  def create
    @partner = Partner.create(partner_params)
    redirect_to action: :index, flash: {notice: "Partner was created"}
  end

  def edit
    @partner = Partner.find(params[:id])
  end

  def update
    @partner = Partner.find(params[:id])
    @partner.update(partner_params)

    redirect_to action: :index
  end

  def destroy
    @partner = Partner.find(params[:id])
    @partner.destroy

    redirect_to action: :index, flash: {notice: "Partner was deleted"}
  end

  private

  def partner_params
    params.require(:partner).permit(:name, :partner_type_id, :url, :logo)
  end
end

