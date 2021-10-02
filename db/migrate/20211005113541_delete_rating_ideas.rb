class DeleteRatingIdeas < ActiveRecord::Migration[6.1]
  def change
    remove_column :ideas, :rating 
  end
end
