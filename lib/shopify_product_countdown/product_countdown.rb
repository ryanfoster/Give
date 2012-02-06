class ProductCountdown
  
  def self.update product
    
     start_date, end_date = ProductTagParser.extract_dates(product.tags)
          
     avalible = is_avalible(start_date, end_date)
     
     set_meta_avalible(product, avalible)
    
  end
    
  def self.get_meta_avalible product
    product.metafields.find{|m| m.namespace=="countdown" && m.key == "avalible" }
  end
  
  def self.set_meta_avalible( product, avalible)
    existing = get_meta_avalible(product)
    avalible = avalible ? 1 : 0
    
    if existing       
      existing.value = avalible
      existing.save
    else
      product.add_metafield( ShopifyAPI::Metafield.new(:namespace => "countdown", :key => "avalible", :value => avalible, :value_type => "integer") )
    end
    
    avalible
         
  end
  
 def self.is_avalible( start_date, end_date )
    
    if (start_date <=> end_date) < 1 then raise "Start date must be before end" end
    
    avalible = false
    
    today = Date.today
    
    if start_date <= today && end_date > today
      avalible = true  
    end
    
    avalible
    
  end
  
end