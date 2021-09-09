class AddSubs < ActiveRecord::Migration[6.1]
  def change
    add_column :ideas, :is_active, :bool,  :default => true
    add_column :ideas, :views, :integer, :default => 0
    add_column :ideas, :close_data, :datetime, precision: 6, :default => Time.now + 30.days
  end
end
