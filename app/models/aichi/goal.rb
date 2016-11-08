class Aichi::Goal < ActiveRecord::Base
  self.table_name = "aichi_goals"

  has_many :aichi_targets, class_name: "Aichi::Target", foreign_key: "aichi_goal_id"
end

