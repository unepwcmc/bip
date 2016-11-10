class AddPositionToSdgGoals < ActiveRecord::Migration
  def change
    add_column :sdg_goals, :position, :integer
  end
end
