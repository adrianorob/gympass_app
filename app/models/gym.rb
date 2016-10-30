class Gym < ApplicationRecord
  belongs_to :user
  has_many :user_tokens, dependent: :destroy
  has_many :tokens, :through => :user_tokens

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :open_time, presence: true
  validates :close_time, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def approve!
    self.approved = true
    self.save
  end

  def self.locked_gyms
    self.where(approved: false).count
  end

end
