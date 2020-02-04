class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string        :zipcode,             null: false
      t.string        :city,                null: false
      t.string        :town,                null: false
      t.string        :house_number,        null: false
      t.string        :building
      t.integer       :phone_number
      t.integer       :user_id,             null: false
      t.timestamps
    end
  end
end
