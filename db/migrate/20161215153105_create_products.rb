class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.references :user, index: true
      t.references :buyer, index: true

      t.timestamps null: false
    end
  end
end
