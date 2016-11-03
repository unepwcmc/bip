class AddCoverageIdToComfyCmsPages < ActiveRecord::Migration
  def change
    add_reference :comfy_cms_pages, :coverage
  end
end
