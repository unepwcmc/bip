class CreateSdgGoals < ActiveRecord::Migration
  def change
    create_table :sdg_goals do |t|
      t.text :name
      t.text :description

      t.timestamps
    end
  end
end
