json.extract! product, :id, :name, :created_at, :updated_at, :user_id
json.url product_url(product, format: :json)
