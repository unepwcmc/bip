class AddTargetNumberToAichiTargets < ActiveRecord::Migration
  def change
    add_column :aichi_targets, :target_number, :text
  end
end
