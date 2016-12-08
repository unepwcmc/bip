class AddPositionToMeaTargets < ActiveRecord::Migration
  def change
    add_column :mea_targets, :position, :float
  end
end
