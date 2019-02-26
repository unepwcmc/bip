class AddAvailableLinkAlternateToComfyCmsPages < ActiveRecord::Migration
  def change
    add_column :comfy_cms_pages, :available_link_alternate, :text
  end  
end
