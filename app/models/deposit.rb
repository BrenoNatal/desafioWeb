class Deposit < ApplicationRecord
  belongs_to :account

  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
