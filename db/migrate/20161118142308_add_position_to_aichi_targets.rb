class AddPositionToAichiTargets < ActiveRecord::Migration
  def change
    add_column :aichi_targets, :position, :integer
  end
end
