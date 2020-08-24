class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users/mypage or root
  def mypage
    @user = current_user
    if current_user.nil?
      redirect_to login_path
    end
    @teams = Team.all
    @team = Team.new

  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  # teamのページから招待の追加でくる。
  def create
    puts "user params"
    puts user_params

    @team = Team.find(user_params["team_id"])

    invited_user_screen_name = user_params["screen_name"].delete("@")

    puts "twitter id"
    puts invited_user_screen_name

    # 追加されたのがまだサービス上に登録されてないユーザーの場合、今は何もしない。
    exist_user = User.find_by(screen_name: invited_user_screen_name)
    if exist_user.nil?
      puts "現在登録されていないユーザーに対するチーム招待"
      respond_to do |format|
        format.html { redirect_to @team, notice: '現在登録されていないユーザーに対するチーム招待' }
    end
    else
      @team_user = TeamUser.new
      @team_user.team = Team.find(user_params["team_id"])
      @team_user.user = current_user
      @team_user.save
      respond_to do |format|
        format.html { redirect_to @team, notice: '現在登録されていないユーザーに対するチーム招待' }
    end

    # @user = User.new(user_params)
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      # params.require(:user).permit(:uid, :twitter_user_id, :screen_name)
      params.permit(:screen_name, :team_id)
    end
end
