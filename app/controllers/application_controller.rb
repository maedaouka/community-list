class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  TWITTER_DEV_CONSUMER_KEY = "vYlAgrKfsaF1pEH7U9oK76b1S"
  TWITTER_DEV_CONSUMER_SECRET = "bLo0FNYpfaY9VCWZpai3E1iSfNeKnKSXKYeo1CdKGA9KK7HveJ"
  TWITTER_DEV_ACCESS_TOKEN = "1097694819239964673-UeejF5wc18yX4cZCqnhvlkLxWDGStb"
  TWITTER_DEV_ACCESS_TOKEN_SECRET = "cbvG5QWkj64ClIcEksh9WzCsddJc3DlSaDLuQkEUSzX9h"

  private                                                        
    # tokenが正規のものであれば、デコード結果を返す
    # そうでなければfalseを返す
    def authenticate_firebase_id_token
      # authenticate_with_http_tokenは、HTTPリクエストヘッダーに
      # Authorizationが含まれていればブロックを評価する。
      # 含まれていなければnilを返す。
      authenticate_with_http_token do |token, options|
        begin
          decoded_token = FirebaseHelper::Auth.verify_id_token(token)
        rescue => e
          logger.error(e.message)
          false
        end
      end
    end
end
