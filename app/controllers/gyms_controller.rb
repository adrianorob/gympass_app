class GymsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show, :search ]

  NEAR_DISTANCE = 10
  MEDIUM_DISTANCE = 30
  FAR_DISTANCE = 500

  def index
    @address = ""
    if current_user
      @gyms_markers = Gym.where(approved: true)
                         .near(current_user.work_address, NEAR_DISTANCE)
      @gyms = Gym.where(approved: true)
                 .page(params[:page]).per(4)
                 .near(current_user.work_address, NEAR_DISTANCE)
    else
      @gyms = Gym.where(approved: true)
                 .page(params[:page]).per(4)
                 .where.not(latitude: nil, longitude: nil)
      @gyms_markers = Gym.where(approved: true)
                         .where.not(latitude: nil, longitude: nil)
    end

    @hash = Gmaps4rails.build_markers(@gyms_markers) do |gym, marker|
      marker.lat gym.latitude
      marker.lng gym.longitude
      marker.infowindow render_to_string(partial: "/gyms/map_box", locals: { gym: gym })
    end
  end

  def index_locked
    @gyms = Gym.where(approved: false).page(params[:page]).per(10)
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

  def approve
    gym = Gym.find(params[:id])
    if current_user.admin?
      gym.approve!
      flash[:notice] = "You've approved gym #{gym.name} succesfully!"
      redirect_to index_locked_path
    else
      flash[:alert] = "You are not able to approve gyms!"
      redirect_to root_path
    end
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

      @gyms_markers = Gym.where(approved: true)
                 .near([-21.998062, -46.241335], FAR_DISTANCE)

      @gyms = Gym.where(approved: true)
                 .page(params[:page]).per(4)
                 .near([-21.998062, -46.241335], FAR_DISTANCE)
    else
      @gyms_markers = Gym.where(approved: true)
                         .near(@address, MEDIUM_DISTANCE)

      @gyms = Gym.where(approved: true)
                 .page(params[:page]).per(4)
                 .near(@address, MEDIUM_DISTANCE)
    end
    @hash = Gmaps4rails.build_markers(@gyms_markers) do |gym, marker|
      marker.lat gym.latitude
      marker.lng gym.longitude
      marker.infowindow render_to_string(partial: "/gyms/map_box", locals: { gym: gym })
    end
    render :index
  end

  private

  def gym_params
    params.require(:gym).permit(:name, :address, :open_time, :close_time, :longitude, :latitude)
  end

end
