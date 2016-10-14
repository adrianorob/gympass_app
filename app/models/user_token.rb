class UserToken < ApplicationRecord
  belongs_to :user
  belongs_to :gym, dependent: :destroy

  tokenizable
end
