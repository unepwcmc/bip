class CreateAichiTargets < ActiveRecord::Migration
  def change
    create_table :aichi_targets do |t|
      t.text :name
      t.text :description
      t.attachment :logo

      t.references :aichi_goal

      t.timestamps
    end
  end
end
