class Transaction < ApplicationRecord
  belongs_to :account_source, class_name: "Account", foreign_key: "account_id_source"
  belongs_to :account_target, class_name: "Account", foreign_key: "account_id_target"

  before_validation :validate_account_num
  validates :account_id_target, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :account_id_source, numericality: { other_than: :account_id_target }
  validate :account_id_source, :amount, :validate_transaction


  def validate_account_num
    account_target = Account.find_by(account_num: account_num_target)

    if account_target.nil?
      self.account_id_target = -1
    else
      self.account_id_target = account_target.id
    end
  end

  def validate_transaction
    account = Account.where(id: account_id_source)[0]

    if ! account.vip?
      if amount > 1000 || amount > account.balance
        errors.add(:amount, "Valor maior que o permitido")
      end
    end
  end
end
