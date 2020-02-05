class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|

      t.timestamps
      t.string      :image,              null: false
      t.integer     :item_id,            null: false, foreign_key: true
      t.integer     :user_id,            null: false, foreign_key: true

    end
  end
end
