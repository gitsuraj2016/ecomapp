json.extract! category, :id, :name, :description, :image_url, :active, :created_at, :updated_at
json.url category_url(category, format: :json)
