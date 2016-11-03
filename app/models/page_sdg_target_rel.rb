class PageSdgTargetRel < ActiveRecord::Base
  belongs_to :page, class_name: "Comfy::Cms::Page"
  belongs_to :sdg_target, class_name: "Sdg::Target"
end

