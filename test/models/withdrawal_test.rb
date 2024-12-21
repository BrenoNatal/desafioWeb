require "test_helper"

class WithdrawalTest < ActiveSupport::TestCase
  test "should not save a withdrawal without amount" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false)
    account1.save
    withdrawal = Withdrawal.new(account_id: account1.id)
    assert_not withdrawal.save, "Saved withdrawal without amount"
  end
  test "should not save a withdrawal without account_id" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false)
    account1.save
    withdrawal = Withdrawal.new(amount: 1)
    assert_not withdrawal.save, "Saved withdrawal without account_id"
  end
  test "should not save a withdrawal with amount greater than account balance if not vip" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false, balance: 100)
    account1.save
    withdrawal = Withdrawal.new(amount: 101)
    assert_not withdrawal.save, "Saved withdrawal with amount greater than account balance"
  end
  test "should save a withdrawal with amount greater than account balance if vip" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: true, balance: 100)
    account1.save
    withdrawal = Withdrawal.new(amount: 101, account_id: account1.id)
    assert withdrawal.save, "Didn't save withdrawal with amount greater than account balance if account is vip"
  end
  test "should save a withdrawal if all conditions are fulfilled" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false, balance: 100)
    account1.save
    withdrawal = Withdrawal.new(amount: 10, account_id: account1.id)
    assert withdrawal.save, "Didn't save withdrawal with all conditions are fulfilled"
  end
end
