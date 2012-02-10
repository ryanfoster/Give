class ProductCountdown
  
  def self.update product
    
     begin
      start_date, end_date = ProductTagParser.extract_dates(product.tags)    
     rescue
      start_date = Date.today + 1.days
      end_date = Date.today + 2.days
     end
     
     start_date += 0.seconds
     end_date += (1.day - 1.seconds)
     
     set_meta(product, "begin_date", start_date.inspect, "string")
     set_meta(product, "begin_date_secs", start_date.to_i, "integer")
     set_meta(product, "end_date", end_date.inspect, "string")
     set_meta(product, "end_date_secs", end_date.to_i, "integer")     
    
  end
    
  def self.get_meta( product, key )
    product.metafields.find{|m| m.namespace=="countdown" && m.key == key}
  end
  
  def self.set_meta( product, key, value, value_type)
    existing = get_meta(product, key)
    
    if existing       
      existing.value = value
      existing.save
    else
      product.add_metafield( ShopifyAPI::Metafield.new(:namespace => "countdown", :key => key, :value => value, :value_type => value_type) )
    end
    
    value
         
  end
  
end