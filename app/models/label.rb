class Label < ApplicationRecord
  belongs_to :board

  has_many :card_labels, dependent: :destroy
  has_many :cards, through: :card_labels
end
