class FirebaseController < ApplicationController
  before_action :logged_in_user, only: [:destroy]

  # GET /login
  def new
    if logged_in?
      redirect_to root_path
    end
  end

  # firebaseから取得した情報を基にuser情報を保存する。
  def create
    if decoded_token = authenticate_firebase_id_token
      user = yield(decoded_token)
      log_in(user)
      flash[:success] = 'ログインしました。'
      redirect_back_or(root_path)
    else
      flash[:danger] = 'ログインできませんでした。'
      redirect_to login_url
    end
  end

  def destroy
    puts "ログアウト"
    log_out if logged_in?
    redirect_to login_url
  end
end