class StatementController < ApplicationController
  before_action :authenticate_account!

  def statement
    if account_signed_in?
      account = current_account
      @list_deposits =  account.deposits
      @list_withdrawals = account.withdrawals
      @list_transactions = Transaction.where("account_id_target = ?", account.id).or(Transaction.where("account_id_source = ?", account.id))
      @all_movements = (@list_deposits + @list_withdrawals + @list_transactions).sort_by(&:created_at).reverse
    end
  end
end
