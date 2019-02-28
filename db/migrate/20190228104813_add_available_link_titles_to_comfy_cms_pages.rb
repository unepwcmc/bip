class AddAvailableLinkTitlesToComfyCmsPages < ActiveRecord::Migration
  def change
    add_column :comfy_cms_pages, :available_link_title_alternate, :text
    add_column :comfy_cms_pages, :available_link_title, :text
  end
end
