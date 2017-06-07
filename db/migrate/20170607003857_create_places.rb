class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :address
      t.string :name
      t.string :comment
      t.string :neighborhood
      t.integer :user_id

      t.timestamps

    end
  end
end
