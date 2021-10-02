class CreateRating < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.integer :user_id
      t.integer :idea_id
      t.timestamps
    end
  end
end
