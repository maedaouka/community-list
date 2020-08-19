class AccountsController < FirebaseController
  # POST /accounts
  def create
    puts "アカウント　作成1"
    super do |decoded_token|
      puts decoded_token
      puts "センテンスパラム "
      puts account_params
      User.create(
        uid: decoded_token['uid'],
        # name: decoded_token['displayName']
        # screen_name: decoded_token['decoded_token'][:payload]['displayName']
        twitter_user_id: decoded_token['decoded_token'][:payload]['user_id'],
        name: decoded_token['decoded_token'][:payload]['name'],
        image_url: decoded_token['decoded_token'][:payload]['picture'],

        screen_name: account_params["screen_name"],

      )
    end
  end

  # Only allow a list of trusted parameters through.
  def account_params
    params.require(:twitter_user).permit(:screen_name)
  end
end
