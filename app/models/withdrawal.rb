class Withdrawal < ApplicationRecord
  belongs_to :account

  validates :account_id, presence: true
  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validate :account_id, :amount, :validate_withdrawal

  def validate_withdrawal
    account = Account.where(id: account_id)[0]

    if ! account
      errors.add(:account_id, "Conta não existe")
    else
      if ! account.vip?
        if amount
          if amount > 1000 || amount > account.balance
            errors.add(:amount, "Valor maior que o permitido")
          end
        else
          errors.add(:amount, "Saque precisa ter valor")
        end
      end
    end
  end
end
