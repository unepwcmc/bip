class AddIndicatorTypeIdToComfyCmsPages < ActiveRecord::Migration
  def change
    add_reference :comfy_cms_pages, :indicator_type
  end
end
