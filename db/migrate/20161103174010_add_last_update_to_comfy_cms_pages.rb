class AddLastUpdateToComfyCmsPages < ActiveRecord::Migration
  def change
    add_column :comfy_cms_pages, :last_update, :datetime
  end
end
