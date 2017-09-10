class ProductBrand < ActiveRecord::Base
  belongs_to :product
  belongs_to :brand
end
