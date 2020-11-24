class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  TWITTER_DEV_CONSUMER_KEY = ENV['TWITTER_DEV_CONSUMER_KEY']
  TWITTER_DEV_CONSUMER_SECRET = ENV['TWITTER_DEV_CONSUMER_SECRET']
  TWITTER_DEV_ACCESS_TOKEN = ENV['TWITTER_DEV_ACCESS_TOKEN']
  TWITTER_DEV_ACCESS_TOKEN_SECRET = ENV['TWITTER_DEV_ACCESS_TOKEN_SECRET']

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
