class Service < ApplicationRecord
  belongs_to :account

  validates :amount, numericality: { greater_than: 0 }
  validates :amount, :service_type, presence: true
  validate :account_id, :amount, :validate_service


  # Validada se a conta pode acessar o serviço, checando se é vip e tem o saldo para pagar
  def validate_service
    account = Account.find_by(id: account_id)

    if ! account.vip?
      errors.add(:account_id, "A conta não é vip")
    else
      if amount
        if amount > account.balance
          errors.add(:amount, "O saldo não é o suficieente para a visita")
        end
      else
        errors.add(:amount, "Serviço sem valor")
      end
    end
  end
end
