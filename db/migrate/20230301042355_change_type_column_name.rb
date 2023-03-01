class ChangeTypeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column(:alerts, :type, :alert_type)
  end
end
