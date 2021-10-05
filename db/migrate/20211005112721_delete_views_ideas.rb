class DeleteViewsIdeas < ActiveRecord::Migration[6.1]
  def change
    remove_column :ideas, :views
  end
end
