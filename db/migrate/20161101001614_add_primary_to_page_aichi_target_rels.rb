class AddPrimaryToPageAichiTargetRels < ActiveRecord::Migration
  def change
    add_column :page_aichi_target_rels, :primary, :boolean
  end
end
