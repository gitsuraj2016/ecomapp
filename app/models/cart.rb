class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	  def add_product(product_id)
       current_item = line_items.find_by(product_id: product_id)
       if current_item
         current_item.quantity += 1
       else
         current_item = line_items.build(product_id: product_id)
       end
       current_item
    end

    def incr_product(product)
      current_item = line_items.find_by(product_id: product.id)
      if current_item
        current_item.quantity += 1
      else
        current_item = line_items.build(product_id: product.id)
      end
      current_item
  end

  def decr_product(product)
      current_item = line_items.find_by(product_id: product.id)
      if current_item.quantity > 1
        current_item.quantity -= 1
      elsif current_item.quantity = 1
        current_item.destroy
      end
      current_item
  end

    def total_price
     line_items.to_a.sum { |item| item.total_price }
    end
end
