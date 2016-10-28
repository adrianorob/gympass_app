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

  has_many :gyms
  has_many :user_tokens

  SECONDS_DAY = 86400

  def admin?
    self.admin
  end

  def regular_user?
    self.type_user == "1"
  end

  def token?
    UserToken.where(user_id: self.id).where("? < created_at ",(Time.now - SECONDS_DAY)).count < 1
  end

  def use_token?
    UserToken.where(user_id: self.id).where("? < created_at ",(Time.now - SECONDS_DAY)).count == 1
  end

  def token_not_assigned_to_gym?
    UserToken.where(user_id: self.id).last.gym.nil?
  end

  def check_gym_manager?(gym)
    gym.user == self
  end

  def disactive_tokens
    count = 0
    self.gyms.each do |gym|
      count += gym.tokens.where(name: 'disactive').size
    end
    count
  end

end
