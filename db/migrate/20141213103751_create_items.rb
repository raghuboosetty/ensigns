class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :customer, index: true
      t.string :token, unique: true
      t.string :size
      t.string :code
      t.decimal :wholesale_price, precision: 6, scale: 2
      t.decimal :retail_price, precision: 6, scale: 2
      t.decimal :selling_price, precision: 6, scale: 2
      t.decimal :discount, precision: 6, scale: 3
      t.string :status, default: "in_stock"
      t.string :payment_status
      t.text :description
      t.decimal :paid_amount, precision: 6, scale: 2
      t.attachment :photo

      t.timestamps
    end
  end
end
