class CreateVariants < ActiveRecord::Migration[8.1]
  def change
    create_table :variants do |t|
      t.string :sku
      t.decimal :price
      t.integer :inventory_count
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
