class CreateClientsProducts < ActiveRecord::Migration
  def change
    create_table :clients_products, id: false do |t|
      t.belongs_to :client, index: true
      t.belongs_to :product, index: true
    end
  end
end
