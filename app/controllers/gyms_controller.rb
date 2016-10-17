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
      GymMailer.gymcreated(@gym.user, @gym).deliver_now
      redirect_to root_path
    else
      render :new
    end
  end

  def update
  end

  def destroy
    gym = Gym.find(params[:id])
    if current_user.admin? || current_user.check_gym_manager?(gym)
      gym.destroy
      flash[:notice] = "You've deleted gym #{gym.name} succesfully!"
      redirect_to root_path
    else
      flash[:alert] = "You do not have permission to delete gym #{gym.name}!"
      redirect_to root_path
    end
  end

  def search
    @address = params[:address_query]
    if params[:address_query].empty?
      @gyms = Gym.near([-21.998062, -46.241335], 500)
    else
      @gyms = Gym.near(@address, 30)
    end
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
