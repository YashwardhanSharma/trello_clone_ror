class Board < ApplicationRecord
  belongs_to :user
  has_many :lists, dependent: :destroy
  has_many :labels, dependent: :destroy
end
