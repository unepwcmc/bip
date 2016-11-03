module CmsAdminExtension
  extend ActiveSupport::Concern

  included do
    before_action :create_resources, :only => [:create, :update]
    before_action :create_disaggregations, :only => [:create, :update]
    before_action :connect_partners, :only => [:create, :update]
    before_action :connect_aichi_targets, :only => [:create, :update]
    before_action :connect_mea_targets, :only => [:create, :update]

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

    def connect_aichi_targets
      if params[:page][:primary_aichi_target_id]
        @page.primary_aichi_target = Aichi::Target.find(params[:page][:primary_aichi_target_id])
      end
      if params[:page][:secondary_aichi_target_ids]
        @page.secondary_aichi_targets = Aichi::Target.where(id: params[:page][:secondary_aichi_target_ids])
      end
    end

    def connect_mea_targets
      if params[:page][:official_mea_target_id]
        @page.official_mea_target = MeaTarget.find(params[:page][:official_mea_target_id])
      end

      if params[:page][:relevant_mea_target_ids]
        @page.relevant_mea_targets = MeaTarget.where(id: params[:page][:relevant_mea_target_ids])
      end
    end
  end
end

Comfy::Admin::Cms::PagesController.send(:include, CmsAdminExtension)
