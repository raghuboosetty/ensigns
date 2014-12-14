class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :customer, index: true
      t.string :token, unique: true
      t.string :size
      t.string :code
      t.decimal :wholesale_price
      t.decimal :retail_price
      t.decimal :selling_price
      t.decimal :discount
      t.string :status
      t.string :payment_status
      t.text :description
      t.decimal :paid_amount
      t.attachment :photo

      t.timestamps
    end
  end
end
