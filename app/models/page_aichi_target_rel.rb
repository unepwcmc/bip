class PageAichiTargetRel < ActiveRecord::Base
  belongs_to :page, class_name: "Comfy::Cms::Page"
  belongs_to :aichi_target, class_name: "Aichi::Target"
end

