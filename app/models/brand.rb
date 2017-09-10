class Brand < ActiveRecord::Base
	has_many :product_brands
	has_many :products, through: :product_brands
end
