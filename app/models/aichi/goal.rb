class Aichi::Goal < ActiveRecord::Base
  self.table_name = "aichi_goals"

  belongs_to :aichi_target, class_name: "Aichi::Target"
end

