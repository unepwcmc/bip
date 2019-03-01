class AddAvailableLinkAlternateToComfyCmsPages < ActiveRecord::Migration
  def change
    add_column :comfy_cms_pages, :available_link_alternate, :text, default: ''
    add_column :comfy_cms_pages, :available_link_title_alternate, :text, default: ''
    add_column :comfy_cms_pages, :available_link_title, :text, default: ''
  end  
end
