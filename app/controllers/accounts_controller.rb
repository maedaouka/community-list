class AccountsController < FirebaseController
  # POST /accounts
  def create
    puts "アカウント　作成"
    super do |decoded_token|
      User.create(
        uid: decoded_token['uid']
      )
    end
  end
end 
