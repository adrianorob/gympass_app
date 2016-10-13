class GymsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  def index
  end

  def show
    @gym = Gym.find(params[:id])
    @gym_coordinates = { lat: @gym.latitude, lng: @gym.longitude }
  end

  def new
    @gym = Gym.new
  end

  def create
    @gym = Gym.new(gym_params)
    @gym.user = current_user
    if @gym.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def gym_params
    params.require(:gym).permit(:name, :address, :open_time, :close_time, :longitude, :latitude)
  end

end
