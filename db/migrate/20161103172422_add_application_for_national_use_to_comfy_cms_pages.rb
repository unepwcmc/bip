class AddApplicationForNationalUseToComfyCmsPages < ActiveRecord::Migration
  def change
    add_column :comfy_cms_pages, :applicable_for_national_use, :boolean
  end
end
