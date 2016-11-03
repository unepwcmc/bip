class PageMeaTargetRel < ActiveRecord::Base
  belongs_to :page, class_name: "Comfy::Cms::Page"
  belongs_to :mea_target
end

