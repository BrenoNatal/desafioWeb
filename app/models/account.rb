class Account < ApplicationRecord
  attr_accessor :login

  before_validation :set_defaults

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable


  # Relacionamento da conta com as suas movimentações
  has_many :deposits
  has_many :withdrawals
  has_many :services

  # Relacionamente com as transferencias
  has_many :transactions_source, class_name: "Transactions", foreign_key: "account_id_source"
  has_many :transactions_target, class_name: "Transactions", foreign_key: "account_id_target"

  # Valida se o vip esta setado e se o numero da conta é unico e tem o tamanho de 5
  validates :vip, inclusion: [ true, false ]
  validates :account_num, uniqueness: true, length: { is: 5 }

  # Configuração para permitir o login com account_num
  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where([ "account_num = :value",
      { value: login.strip.downcase } ]).first
  end

  # Coloca o saldo da conta como 0
  def set_defaults
    self.balance = 0 if self.balance.blank?
  end

  # Método para reduzir o saldo em 0.1%
  def reduce_balance!
    return unless balance.negative?

    # Reduz 0.1% do saldo
    self.balance = self.balance + (self.balance *  0.001)
    save!
  end

  # Verifica se o saldo foi suficiente para cobrir o negativo
  def balance_positive?
    balance >= 0
  end
end
