class CreateClientProducts < ActiveRecord::Migration
  def change
    create_table :client_products do |t|
      t.belongs_to :client, index: true
      t.belongs_to :product, index: true
    end
  end
end
