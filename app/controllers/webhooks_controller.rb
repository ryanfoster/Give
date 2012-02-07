class WebhookController < ApplicationController

  #before_filter :verify_webhook, :except => 'verify_webhook'

  def product_new
    data = ActiveSupport::JSON.decode(request.body.read)
    if data["id"]
       product = ShopifyAPI::Product.find( params[:id] )
       ProductCountdown.update product
    end
      head :ok
  end

  def product_updated
    data = ActiveSupport::JSON.decode(request.body.read)

    if data["id"]
       product = ShopifyAPI::Product.find( params[:id] )
       ProductCountdown.update product
    end
      head :ok
  end

  private
  
  # def verify_webhook
    # data = request.body.read.to_s
    # hmac_header = request.headers['HTTP_X_SHOPIFY_HMAC_SHA256']
    # digest  = OpenSSL::Digest::Digest.new('sha256')
    # calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, Give:Application.config.shopify.secret, data)).strip
    # unless calculated_hmac == hmac_header
      # head :unauthorized
    # end
    # request.body.rewind
  # end

end
