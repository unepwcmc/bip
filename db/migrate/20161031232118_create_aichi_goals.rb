class CreateAichiGoals < ActiveRecord::Migration
  def change
    create_table :aichi_goals do |t|
      t.text :name
      t.text :description

      t.timestamps
    end
  end
end
