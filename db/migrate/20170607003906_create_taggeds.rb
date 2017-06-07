class CreateTaggeds < ActiveRecord::Migration[5.0]
  def change
    create_table :taggeds do |t|
      t.integer :place_id
      t.integer :tag_id

      t.timestamps

    end
  end
end
