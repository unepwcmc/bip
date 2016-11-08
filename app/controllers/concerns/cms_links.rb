module CmsAdminExtension
  extend ActiveSupport::Concern

  included do
    after_action :create_resources, :only => [:create, :update]
    after_action :create_disaggregations, :only => [:create, :update]
    after_action :connect_partners, :only => [:create, :update]
    after_action :connect_aichi_targets, :only => [:create, :update]
    after_action :connect_mea_targets, :only => [:create, :update]
    after_action :connect_sdg_targets, :only => [:create, :update]
    after_action :connect_key_facts, :only => [:create, :update]

    def create_resources
      Array.wrap(params[:resources]).each do |resource|
        @page.resources.create!(label: resource[:label], file: resource[:file])
      end
    end

    def create_disaggregations
      @page.disaggregation_targets = Comfy::Cms::Page.where(id: params[:page][:disaggregation_target_ids])
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

    def connect_sdg_targets
      if params[:page][:official_sdg_target_id]
        @page.official_sdg_target = Sdg::Target.find(params[:page][:official_sdg_target_id])
      end

      if params[:page][:relevant_sdg_target_ids]
        @page.relevant_sdg_targets = Sdg::Target.where(id: params[:page][:relevant_sdg_target_ids])
      end
    end

    def connect_key_facts
      if params[:page][:indicator_type_id]
        @page.indicator_type = IndicatorType.find(params[:page][:indicator_type_id])
      end

      if params[:page][:indicator_classification_id]
        @page.indicator_classification = IndicatorClassification.find(params[:page][:indicator_classification_id])
      end

      @page.applicable_for_national_use = params[:page].has_key?(:applicable_for_national_use)
      if params[:page][:last_update]
        @page.last_update = Date.new(params[:page][:last_update].to_i, 1, 1)
      end

      if params[:page][:coverage_id]
        @page.coverage = Coverage.find(params[:page][:coverage_id])
      end

      @page.freely_available = params[:page].has_key?(:freely_available)
      @page.available_link = params[:page][:available_link]
    end
  end
end

Comfy::Admin::Cms::PagesController.send(:include, CmsAdminExtension)
