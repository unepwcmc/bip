class AddAvailableLinkToComfyCmsPages < ActiveRecord::Migration
  def change
    add_column :comfy_cms_pages, :available_link, :text
  end
end
