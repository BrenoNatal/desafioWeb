class Service < ApplicationRecord
  belongs_to :account

  validates :amount, numericality: { greater_than: 0 }
  validate :account_id, :amount, :validate_service

  def validate_service
    account = Account.find_by(id: account_id)

    if ! account.vip?
      if amount > 1000 || amount > account.balance
        errors.add(:amount, "Valor maior que o permitido")
      end
    end
  end
end
