class CreateAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :areas do |t|
      t.string :postcode
      t.float :latitude
      t.float :longitude
      t.string :district
      t.string :ward
      t.string :constituency

      t.timestamps
    end
  end
end
