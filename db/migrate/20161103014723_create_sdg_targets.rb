class CreateSdgTargets < ActiveRecord::Migration
  def change
    create_table :sdg_targets do |t|
      t.text :target_number
      t.text :name
      t.text :description
      t.attachment :logo

      t.references :sdg_goal

      t.timestamps
    end
  end
end
