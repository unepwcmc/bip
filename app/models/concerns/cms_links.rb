module CmsLinks
  extend ActiveSupport::Concern

  included do
    has_many :resources, foreign_key: "comfy_cms_page_id"

    has_many :disaggregations, foreign_key: "parent_id"
    has_many :disaggregation_targets, through: :disaggregations, source: :target

    has_many :related_contents, foreign_key: "parent_id"
    has_many :related_content_targets, through: :related_contents, source: :target

    has_many :page_partner_rels, dependent: :destroy
    has_many :partners, through: :page_partner_rels

    has_many :page_mea_target_rels, dependent: :destroy
    has_many :mea_targets, through: :page_mea_target_rels

    has_many :official_page_mea_target_rels, -> { where(official: true) }, class_name: "PageMeaTargetRel"
    has_many :official_mea_targets, through: :official_page_mea_target_rels, class_name: "MeaTarget", source: :mea_target

    has_many :relevant_page_mea_target_rels, -> { where(official: false) }, class_name: "PageMeaTargetRel"
    has_many :relevant_mea_targets, through: :relevant_page_mea_target_rels, class_name: "MeaTarget", source: :mea_target

    has_many :page_sdg_target_rels, dependent: :destroy
    has_many :sdg_targets, through: :page_sdg_target_rels

    has_many :official_page_sdg_target_rels, -> { where(official: true) }, class_name: "PageSdgTargetRel"
    has_many :official_sdg_targets, through: :official_page_sdg_target_rels, class_name: "Sdg::Target", source: :sdg_target

    has_many :relevant_page_sdg_target_rels, -> { where(official: false) }, class_name: "PageSdgTargetRel"
    has_many :relevant_sdg_targets, through: :relevant_page_sdg_target_rels, class_name: "Sdg::Target", source: :sdg_target

    has_many :page_theme_rels, dependent: :destroy
    has_many :themes, through: :page_theme_rels

    belongs_to :indicator_type
    belongs_to :indicator_classification
    belongs_to :coverage

    has_many :page_tag_rels, dependent: :destroy
    has_many :other_tags, through: :page_tag_rels, source: :tag

    has_one :initiative, foreign_key: "comfy_cms_page_id", dependent: :destroy
  end
end

Comfy::Cms::Page.send(:include, CmsLinks)
