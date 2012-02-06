class ProductsController < ApplicationController
  
  def update
    product = ShopifyAPI::Product.find( params[:id] )
    
    start_date, end_date = ProductTagParser.extract_dates(product.tags)
     
     
    
  end

end
