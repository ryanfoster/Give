class TimeController < ApplicationController
  
  def index    
   render :json => {:datetime => Time.now.to_i}, :callback => params[:callback]
     
  end

end
