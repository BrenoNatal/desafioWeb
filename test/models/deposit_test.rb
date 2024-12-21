require "test_helper"

class DepositTest < ActiveSupport::TestCase
  test "should not save a deposit without amount" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false)
    account1.save
    deposit = Deposit.new(account_id: account1.id)
    assert_not deposit.save, "Saved deposit without amount"
  end
  test "should not save a deposit without account_id" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false)
    account1.save
    deposit = Deposit.new(amount: 1)
    assert_not deposit.save, "Saved deposit without account_id"
  end
  test "should save a deposit if all conditions are fulfilled" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false)
    account1.save
    deposit = Deposit.new(amount: 10, account_id: account1.id)
    assert deposit.save, "Didn't save deposit with all conditions are fulfilled"
  end
end
