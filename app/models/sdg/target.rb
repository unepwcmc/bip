class Sdg::Target < ActiveRecord::Base
  self.table_name = "sdg_targets"

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  belongs_to :sdg_goal, class_name: "Sdg::Goal"

  has_many :page_sdg_target_rels, foreign_key: "sdg_target_id"
  has_many :pages, through: :page_sdg_target_rels
end
