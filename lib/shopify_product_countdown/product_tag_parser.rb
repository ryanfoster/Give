class ProductTagParser
  
  def self.extract_dates tags    
    t = tags.split(",")    
    start_tag = t.find{ |s| s.index("[begin]") }
    end_tag = t.find{ |s| s.index("[end]") }
    
    if start_tag && end_tag 
      start_date = parse_to_date( extract_date_string( start_tag ) )
      end_date = parse_to_date( extract_date_string( end_tag ) )
      
      return start_date, end_date
    else
      raise "Tags don't contain start / end date"
    end
    
  end
  
  def self.extract_date_string s    
    s[s.index("]")+1, s.length].strip
  end
  
  def self.parse_to_date s
    # assume uk date format, might need to change to mm/dd/yy later
    Date.parse(s)
  end

end 
  