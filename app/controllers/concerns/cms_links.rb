module CmsAdminExtension
  extend ActiveSupport::Concern

  included do
    after_action :create_resources, :only => [:create, :update]
    after_action :update_resources, :only => [:update]
    after_action :create_disaggregations, :only => [:create, :update]
    after_action :connect_partners, :only => [:create, :update]
    after_action :connect_mea_targets, :only => [:create, :update]
    after_action :connect_sdg_targets, :only => [:create, :update]
    after_action :connect_key_facts, :only => [:create, :update]
    after_action :connect_tags, :only => [:create, :update]
    after_action :connect_initiative, :only => [:create, :update]

    def create_resources
      if params[:resources]
        starting_index = @page.resources.select("MAX(index) AS max_index").order("").first.max_index || 0

        params[:resources].reject { |resource|
          resource[:id].present?
        }.select { |resource|
          resource[:label].present?
        }.map do |resource|
          starting_index += 1

          @page.resources << Resource.create!(
            kind: resource[:kind],
            url: resource[:url],
            is_key: resource[:is_key] == "1",
            label: resource[:label],
            file: resource[:file],
            resource_type_id: resource[:resource_type_id],
            index: starting_index
          )
        end
      end
    end

    def update_resources
      (params[:resources] || []).select { |resource| resource[:id].present? }.each do |resource_attrs|
        resource = Resource.find(resource_attrs[:id])
        resource_attrs[:is_key] = (resource_attrs[:is_key] == "1")
        resource.update(resource_attrs.permit(:url, :is_key, :label, :kind, :index, :file, :resource_type_id))
      end
    end

    def create_disaggregations
      if @page.layout.label == "Indicator page"
        @page.disaggregation_targets = Comfy::Cms::Page.where(id: params[:page][:disaggregation_target_ids])
      else
        @page.disaggregations = []
      end
    end

    def connect_partners
      if @page.layout.label == "Indicator page"
        @page.partners = Partner.where(id: params[:page][:partner_ids])
      else
        @page.partners = []
      end
    end

    def connect_mea_targets
      if @page.layout.label == "Indicator page"
        if params[:page][:official_mea_target_id]
          @page.official_mea_target = MeaTarget.find(params[:page][:official_mea_target_id])
        end

        if params[:page][:relevant_mea_target_ids]
          @page.relevant_mea_targets = MeaTarget.where(id: params[:page][:relevant_mea_target_ids])
        end
      else
        @page.mea_targets = []
      end
    end

    def connect_sdg_targets
      if @page.layout.label == "Indicator page"
        if params[:page][:official_sdg_target_id]
          @page.official_sdg_target = Sdg::Target.find(params[:page][:official_sdg_target_id])
        end

        if params[:page][:relevant_sdg_target_ids]
          @page.relevant_sdg_targets = Sdg::Target.where(id: params[:page][:relevant_sdg_target_ids])
        end
      else
        @page.sdg_targets = []
      end
    end

    def connect_key_facts
      return true unless @page.layout.label == "Indicator page"
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
      @page.available_link_alternate = params[:page][:available_link_alternate]
      @page.available_link_title = params[:page][:available_link_title]
      @page.available_link_title_alternate = params[:page][:available_link_title_alternate]
      @page.peer_reviewed = params[:page].has_key?(:peer_reviewed)
      @page.save
    end

    def connect_tags
      return unless params[:page][:tags]

      tags = params[:page][:tags].map do |name_or_id|
        name_or_id.to_i > 0 ? Tag.find(name_or_id.to_i) : Tag.create(name: name_or_id)
      end

      @page.other_tags = tags
    end

    def connect_initiative
      return unless @page.layout.label == "Indicator initiative" && params[:initiative].present?

      if params[:initiative][:id]
        initiative = Initiative.find(params[:initiative][:id])
        initiative.update_attributes(initiative_params)
        initiative.logo = initiative_params[:logo] if initiative_params[:logo]
        initiative.save
      else
        @page.initiative = Initiative.create!(initiative_params)
      end
    end

    private

    def initiative_params
      params.require(:initiative).permit(:scale, :year_started, :organization_responsible, :focal_point, :countries_included, :number_of_indicators, :framework, :logo)
    end
  end
end

Comfy::Admin::Cms::PagesController.send(:include, CmsAdminExtension)
