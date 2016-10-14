class UserToken < ApplicationRecord
  belongs_to :user
  belongs_to :gym

  tokenizable
end
