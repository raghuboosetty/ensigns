json.array!(@items) do |item|
  json.extract! item, :id, :customer_id, :token, :size, :code, :wholesale_price, :retail_price, :selling_price, :discount, :status, :payment_status, :description, :paid_amout, :photo
  json.url item_url(item, format: :json)
end
