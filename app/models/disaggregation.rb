class Disaggregation < ActiveRecord::Base
  belongs_to :parent, class_name: "Comfy::Cms::Page", foreign_key: "parent_id"
  belongs_to :target, class_name: "Comfy::Cms::Page", foreign_key: "target_id"
end
