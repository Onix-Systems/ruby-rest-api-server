class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer :client_type, null: false
      t.column :gln, :bigint, null: false
      t.string :full_name, null: false
      t.string :short_name, null: false
      t.text :description, null: false

      t.timestamps null: false
    end

    add_index :clients, :gln, unique: true
    add_index :clients, :full_name, unique: true
    add_index :clients, :short_name, unique: true
  end
end
