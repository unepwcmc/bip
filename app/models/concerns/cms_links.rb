module CmsLinks
  extend ActiveSupport::Concern

  included do
    has_many :resources, foreign_key: "comfy_cms_page_id"
    has_many :disaggregations, foreign_key: "comfy_cms_page_id"

    has_many :page_partner_rels
    has_many :partners, through: :page_partner_rels
  end
end

Comfy::Cms::Page.send(:include, CmsLinks)
