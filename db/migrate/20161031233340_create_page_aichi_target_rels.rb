class CreatePageAichiTargetRels < ActiveRecord::Migration
  def change
    create_table :page_aichi_target_rels do |t|
      t.integer :page_id
      t.references :aichi_target

      t.timestamps
    end
  end
end
