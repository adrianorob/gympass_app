class GymsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :search ]

  def index
    if current_user
      @gyms = Gym.near(current_user.work_address, 10)
    else
      @gyms = Gym.where.not(latitude: nil, longitude: nil)
    end

    @hash = Gmaps4rails.build_markers(@gyms) do |gym, marker|
      marker.lat gym.latitude
      marker.lng gym.longitude
      marker.infowindow render_to_string(partial: "/gyms/map_box", locals: { gym: gym })
    end
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

  def search
    @address = params[:address_query]
    @gyms = Gym.near(@address, 30)
    @hash = Gmaps4rails.build_markers(@gyms) do |gym, marker|
      marker.lat gym.latitude
      marker.lng gym.longitude
      marker.infowindow render_to_string(partial: "/gyms/map_box", locals: { gym: gym })
    end
  end

  private

  def gym_params
    params.require(:gym).permit(:name, :address, :open_time, :close_time, :longitude, :latitude)
  end

end
