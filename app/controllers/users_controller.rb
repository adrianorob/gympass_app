class UsersController < ApplicationController
  before_action :authenticate_user!

  # Regular user get a token
  def get_token
    if current_user.token?
      UserToken.create(user: current_user).add_token(:disactive,
                                                      expires_at: Time.now.end_of_day)
      flash[:notice] = "You've got a token (at: #{Time.now}) until #{Time.now.end_of_day}"
      redirect_to root_path
    else
      user_token = UserToken.where(user_id: current_user)
                            .where("? < created_at ",(Time.now - 1.day.to_i)).first
      flash[:alert] = "You've already got valid token (at: #{user_token.tokens.first.created_at}) that expires at #{user_token.tokens.first.expires_at}"
      redirect_to root_path
    end
  end

  # Regular user use his token
  def use_token
    if current_user.use_token? && current_user.token_not_assigned_to_gym?
      gym = Gym.find(params[:id])
      usertoken = UserToken.where(user_id: current_user.id).last
      usertoken.gym = gym
      usertoken.save
      flash[:notice] = "You've got a token to use once at Gym #{gym.name} and its available until the end of the day"
      redirect_to root_path
    else
      user_token = UserToken.where(user_id: current_user)
                            .where("? < created_at ",(Time.now - 1.day.to_i)).first
      if user_token.nil?
        flash[:alert] = "You did not retrieve your daily Token yet!"
      else
        flash[:alert] = "You already used your daily Token!"
      end
      redirect_to root_path
    end
  end

  def index_regular
    tokens = current_user.user_tokens
    @list_tokens = tokens
  end

  # => Managers
  #
  def validate_user_token
    token = Token.find(params[:id])
    token.name = "active"
    if token.save
      flash[:notice] = "You validated a Token"
      redirect_to list_gym_tokens_path
    else
      flash[:alert] = "You could not validate"
      redirect_to list_gym_tokens_path
    end
  end

  def index_manager
    gyms = current_user.gyms
    list = []
    gyms.each do |gym|
      if !gym.user_tokens.empty?
        list << [gym.user_tokens, gym]
      end
    end
    @list_tokens = list
  end

  def show_manager
    @gym = Gym.find(params[:id])
    @list_tokens = @gym.tokens.where(name: "disactive")
    @list_tokens_active = @gym.tokens.where(name: "active")
  end

end
