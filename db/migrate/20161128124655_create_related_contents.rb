class CreateRelatedContents < ActiveRecord::Migration
  def change
    create_table :related_contents do |t|
      t.integer :parent_id
      t.integer :target_id

      t.timestamps
    end
  end
end
