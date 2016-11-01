class Aichi::Target < ActiveRecord::Base
  self.table_name = "aichi_targets"

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  belongs_to :aichi_goal, class_name: "Aichi::Goal"

  has_many :page_aichi_target_rels, foreign_key: "aichi_target_id"
  has_many :pages, through: :page_aichi_target_rels
end
