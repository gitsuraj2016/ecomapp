json.extract! product, :id, :name, :description, :image_url, :price, :curr_status, :category_id, :created_at, :updated_at
json.url product_url(product, format: :json)
