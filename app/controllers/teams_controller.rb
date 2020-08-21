class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @user = current_user
    @new_user = User.new
    @members = User.all
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    puts(team_params)

    @twitter = Twitter::REST::Client.new do |config|
      config.consumer_key        = "vYlAgrKfsaF1pEH7U9oK76b1S"
      config.consumer_secret     = "bLo0FNYpfaY9VCWZpai3E1iSfNeKnKSXKYeo1CdKGA9KK7HveJ"
      config.access_token        = "1097694819239964673-UeejF5wc18yX4cZCqnhvlkLxWDGStb"
      config.access_token_secret = "cbvG5QWkj64ClIcEksh9WzCsddJc3DlSaDLuQkEUSzX9h"
    end

    @twitter.create_list(@team.name, option = {description: @team.explanation})
    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      puts(params[:uid])
      @team = Team.find_by!(uid: params[:uid])
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:uid, :name,:explanation)
    end

    def set_twitter_client
      @twitter = Twitter::REST::Client.new do |config|
        config.consumer_key        = "vYlAgrKfsaF1pEH7U9oK76b1S"
        config.consumer_secret     = "bLo0FNYpfaY9VCWZpai3E1iSfNeKnKSXKYeo1CdKGA9KK7HveJ"
        config.access_token        = "1097694819239964673-UeejF5wc18yX4cZCqnhvlkLxWDGStb"
        config.access_token_secret = "cbvG5QWkj64ClIcEksh9WzCsddJc3DlSaDLuQkEUSzX9h"
      end
    end
end
