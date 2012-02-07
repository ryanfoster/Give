class ProductsController < ApplicationController
  
  def update_all
    product = ShopifyAPI::Product.all
    
    product.each do |p|  
      #begin     
        ProductCountdown.update p
      #rescue
      #end
    end
    
     head :ok
     
  end

end
