class AddLogoToSdgGoals < ActiveRecord::Migration
  def change
    add_attachment :sdg_goals, :logo
  end
end
