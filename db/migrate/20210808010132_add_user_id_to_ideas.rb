class AddUserIdToIdeas < ActiveRecord::Migration[6.1]
  def change
    add_column :ideas, :user_id, :integer
  end
end
