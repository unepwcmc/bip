module CmsAdminExtension
  extend ActiveSupport::Concern

  included do
    before_action :create_resources, :only => [:create, :update]

    def create_resources
      return unless params[:resources]

      params[:resources].each do |resource|
        @page.resources.create!(label: resource[:label], file: resource[:file])
      end
    end

    before_action :create_disaggregations, :only => [:create, :update]

    def create_disaggregations
      return unless params[:disaggregations]

      params[:disaggregations].each do |disaggregation|
        @page.disaggregations.create!(label: disaggregation[:label], url: disaggregation[:url])
      end
    end

  end
end

Comfy::Admin::Cms::PagesController.send(:include, CmsAdminExtension)
