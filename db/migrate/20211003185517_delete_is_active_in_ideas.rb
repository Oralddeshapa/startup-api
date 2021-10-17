class DeleteIsActiveInIdeas < ActiveRecord::Migration[6.1]
  def change
    remove_column :ideas, :is_active
  end
end
