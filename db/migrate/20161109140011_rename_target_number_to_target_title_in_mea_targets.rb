class RenameTargetNumberToTargetTitleInMeaTargets < ActiveRecord::Migration
  def change
    rename_column :mea_targets, :target_number, :target_title
  end
end
