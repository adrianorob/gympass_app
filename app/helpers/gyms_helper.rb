module GymsHelper

  def check_gym_manager?(gym)
    gym.user == current_user
  end

end
