class Product < ActiveRecord::Base
  belongs_to :subcategory
  has_many :line_items
  has_many :product_colors, :dependent => :destroy
  has_many :colors, through: :product_colors
  accepts_nested_attributes_for :product_colors, :allow_destroy => true, :reject_if => :all_blank
  has_many :product_brands, :dependent => :destroy
  has_many :brands, through: :product_brands
  accepts_nested_attributes_for :product_brands, :allow_destroy => true, :reject_if => :all_blank
  
  # before_destroy :ensure_not_referenced_by_any_line_item

  mount_uploader :image_url, ImageUploader

 private

 def ensure_not_referenced_by_any_line_item
	if line_items.empty?
	   return true
	else
	   errors.add(:base, 'Line Items present')
	   return false
	 end
  end
 
end
