class CreateSales < ActiveRecord::Migration[5.0]
  def change
    create_table :sales do |t|
      t.monetize :price, default: 0
      t.integer :amount, default: 0
      t.text :address
      t.references :shopper, foreign_key: true
      t.references :product, foreign_key: true
      t.references :supplier, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
