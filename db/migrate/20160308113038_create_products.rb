class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.bigint :gtin, null: false
      t.bigint :information_provider_gln, null: false
      t.string :bar_code_type, null: false
      t.string :unit_descriptor, null: false
      t.string :internal_supplier_code, null: false
      t.string :brand_name, null: false
      t.string :description_short, null: false
      t.text :description_full, null: false
      t.boolean :active, default: true, null: false

      t.timestamps null: false
    end
    add_index :products, :gtin, unique: true
    add_index :products, :information_provider_gln
    add_index :products, :active
  end
end
