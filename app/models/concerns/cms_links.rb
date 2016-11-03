module CmsLinks
  extend ActiveSupport::Concern

  included do
    has_many :resources, foreign_key: "comfy_cms_page_id"
    has_many :disaggregations, foreign_key: "comfy_cms_page_id"

    has_many :page_partner_rels
    has_many :partners, through: :page_partner_rels

    has_many :page_aichi_target_rels
    has_many :aichi_targets, through: :page_aichi_target_rels

    has_one :primary_page_aichi_target_rel, -> { where(primary: true) }, class_name: "PageAichiTargetRel"
    has_one :primary_aichi_target, through: :primary_page_aichi_target_rel, class_name: "Aichi::Target", source: :aichi_target

    has_many :secondary_page_aichi_target_rels, -> { where(primary: false) }, class_name: "PageAichiTargetRel"
    has_many :secondary_aichi_targets, through: :secondary_page_aichi_target_rels, class_name: "Aichi::Target", source: :aichi_target

    has_many :page_mea_target_rels
    has_many :mea_targets, through: :page_mea_target_rels

    has_one :official_page_mea_target_rel, -> { where(official: true) }, class_name: "PageMeaTargetRel"
    has_one :official_mea_target, through: :official_page_mea_target_rel, class_name: "MeaTarget", source: :mea_target

    has_many :relevant_page_mea_target_rels, -> { where(official: false) }, class_name: "PageMeaTargetRel"
    has_many :relevant_mea_targets, through: :relevant_page_mea_target_rels, class_name: "MeaTarget", source: :mea_target

    def primary_aichi_target_id= id
      self.primary_aichi_target = Aichi::Target.find(id)
    end

    def official_mea_target_id= id
      self.official_mea_target = MeaTarget.find(id)
    end
  end
end

Comfy::Cms::Page.send(:include, CmsLinks)
