class ChangeDefaultAvailableLinkForComfyCmsPages < ActiveRecord::Migration
  def change
    change_column :comfy_cms_pages, :available_link, :text, default: ''
  end
end
