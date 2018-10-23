class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.integer :user_id
      t.integer :area_id
      t.integer :score
      t.string :difficulty

      t.timestamps
    end
  end
end
