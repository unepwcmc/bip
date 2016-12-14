class Sdg::Target < ActiveRecord::Base
  self.table_name = "sdg_targets"

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  belongs_to :sdg_goal, class_name: "Sdg::Goal"

  has_many :page_sdg_target_rels, foreign_key: "sdg_target_id", dependent: :destroy
  has_many :pages, through: :page_sdg_target_rels

  has_many :official_pages, -> { where("page_sdg_target_rels.official IS TRUE") }, through: :page_sdg_target_rels, source: :page
  has_many :relevant_pages, -> { where("page_sdg_target_rels.official IS FALSE") }, through: :page_sdg_target_rels, source: :page
end
