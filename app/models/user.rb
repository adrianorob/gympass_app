class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true
  validates :type_user, presence: true
  validates :work_address, presence: true
  validates :home_address, presence: true, if: :regular_user?

  def admin?
    self.admin
  end

  def regular_user?
    self.type_user == "1"
  end

  def token?
    UserToken.where(user_id: self.id).where("? < created_at ",(Time.now - 86400)).count < 1
  end

end
