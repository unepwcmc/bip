class CreateMeaTargets < ActiveRecord::Migration
  def change
    create_table :mea_targets do |t|
      t.text :target_number
      t.text :name
      t.text :description
      t.references :mea

      t.attachment :logo
      t.timestamps
    end
  end
end
