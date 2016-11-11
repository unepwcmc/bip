class AddPeerReviewedToComfyCmsPages < ActiveRecord::Migration
  def change
    add_column :comfy_cms_pages, :peer_reviewed, :boolean
  end
end
