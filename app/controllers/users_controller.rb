class UsersController < ApplicationController
  before_action :authenticate_user!

  def register_address
    @useraddress = Useraddress.new
  end

  def register_address
    @useraddress = Useraddress.new
  end

end
