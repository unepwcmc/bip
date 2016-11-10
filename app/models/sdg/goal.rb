class Sdg::Goal < ActiveRecord::Base
  self.table_name = "sdg_goals"

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  has_many :sdg_targets, class_name: "Sdg::Target", foreign_key: "sdg_goal_id"
end

