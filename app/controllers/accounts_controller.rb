class AccountsController < FirebaseController
  # POST /accounts
  def create
    puts "アカウント　作成"
    puts decoded_token
    super do |decoded_token|
      User.create(
        uid: decoded_token['uid']
      )
    end
  end
end 
