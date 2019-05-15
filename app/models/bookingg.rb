class Bookingg < ApplicationRecord
  belongs_to :user

  validates :seat, uniqueness: true
end
