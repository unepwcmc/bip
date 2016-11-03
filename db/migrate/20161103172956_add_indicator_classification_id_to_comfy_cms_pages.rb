class AddIndicatorClassificationIdToComfyCmsPages < ActiveRecord::Migration
  def change
    add_reference :comfy_cms_pages, :indicator_classification
  end
end
