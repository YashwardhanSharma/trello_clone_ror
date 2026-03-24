class Card < ApplicationRecord
  belongs_to :list
  has_many :card_labels, dependent: :destroy
  has_many :labels, through: :card_labels
end
