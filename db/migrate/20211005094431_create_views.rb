class CreateViews < ActiveRecord::Migration[6.1]
  def change
    create_table :views do |t|
      t.integer :user_id
      t.integer :idea_id
      t.timestamps
    end
  end
end
