module CmsAdminExtension
  extend ActiveSupport::Concern

  included do
    before_action :create_resources, :only => [:create, :update]
    before_action :create_disaggregations, :only => [:create, :update]
    before_action :connect_partners, :only => [:create, :update]

    def create_resources
      Array.wrap(params[:resources]).each do |resource|
        @page.resources.create!(label: resource[:label], file: resource[:file])
      end
    end

    def create_disaggregations
      Array.wrap(params[:disaggregations]).each do |disaggregation|
        @page.disaggregations.create!(label: disaggregation[:label], url: disaggregation[:url])
      end
    end

    def connect_partners
      @page.partners = Partner.where(id: params[:page][:partner_ids])
    end
  end
end

Comfy::Admin::Cms::PagesController.send(:include, CmsAdminExtension)
