json.extract! sale, :id, :price, :amount, :address, :created_at, :updated_at, :user_id, :shopper_id, :product_id, :supplier_id
json.url sale_url(sale, format: :json)
