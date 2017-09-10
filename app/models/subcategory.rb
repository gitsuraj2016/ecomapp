class Subcategory < ActiveRecord::Base
  belongs_to :category
  has_many :products

  mount_uploader :image_url, ImageUploader
end
