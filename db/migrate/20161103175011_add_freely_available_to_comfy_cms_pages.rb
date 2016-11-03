class AddFreelyAvailableToComfyCmsPages < ActiveRecord::Migration
  def change
    add_column :comfy_cms_pages, :freely_available, :boolean
  end
end
