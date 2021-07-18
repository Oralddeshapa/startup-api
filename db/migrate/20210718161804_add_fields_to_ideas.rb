class AddFieldsToIdeas < ActiveRecord::Migration[6.1]
  def change
    add_column :ideas, :rating, :float
    add_column :ideas, :field, :integer
    add_column :ideas, :region, :integer
  end
end
