class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string        :zipcode,             null: false
      t.string        :city,                null: false
      t.string        :town,                null: false
      t.string        :house_number,        null: false
      t.string        :building
      t.string        :phone_number
      t.references    :user,                foreign_key: true
      t.timestamps
    end
  end
end
