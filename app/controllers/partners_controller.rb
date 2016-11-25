class PartnersController < ApplicationController
  def index
    @partners = Partner.order(:name).all
  end
end
