class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string          :name,                null: false
      t.integer         :status,              null: false, limit: 1
      t.text            :body,                null: false
      t.integer         :price,               null: false
      t.integer         :fee,                 null: false
      t.string          :region,              null: false
      t.integer         :delivery_day,        null: false
      t.integer         :seller_id
      t.integer         :buyer_id          
      t.timestamps
    end
  end
end
