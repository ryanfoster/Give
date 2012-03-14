class ProductCountdown
  
  def self.update product
    
     begin
      start_date, end_date = ProductTagParser.extract_dates(product.tags)    
      start_date += 0.seconds
      end_date += (1.day - 1.seconds)
     rescue
       # problem getting date? assume it was in the past
      start_date = nil
      end_date = nil
     end
          
    set_countdown(product, start_date, end_date)
    
  end
  
  def self.set_countdown(product, start_date, end_date)
    start_string = ""
    end_string = ""
    
    if start_date && end_date
      start_string = start_date.strftime("%a, %d %b %Y %H:%M:%S %Z")
      end_string = end_date.strftime("%a, %d %b %Y %H:%M:%S %Z")
    end
    
    set_meta(product, "begin_date_secs", start_date ? start_date.to_i : 0, "integer")
    set_meta(product, "end_date_secs", end_date ? end_date.to_i : 0, "integer")
           
    set_meta(product, "begin_date", start_string, "string")
    set_meta(product, "end_date", end_string, "string")
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