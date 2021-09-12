class ChangeCloseDataIdeas < ActiveRecord::Migration[6.1]
  def change
    rename_column :ideas, :close_data, :close_date
    change_column_default :ideas, :close_date, nil
  end
end
