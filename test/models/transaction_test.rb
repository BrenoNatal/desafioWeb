require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  test "should save a transaction with all the conditions" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false, balance: 1000)
    account2 = Account.new(account_num: 98766, password: 2345, email: "teste2@email.com", vip: false,  balance: 1000)

    account1.save
    account2.save

    transaction = Transaction.new(amount: 10, description: "", account_id_target: account1.id, account_id_source: account2.id, account_num_target: account1.account_num, account_num_source: account2.account_num, fee: 8)
    assert transaction.save, "Didn't save the transcation"
  end
  test "should not save a transaction with same account num" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false, balance: 1000)
    account2 = Account.new(account_num: 98766, password: 2345, email: "teste2@email.com", vip: false,  balance: 1000)

    account1.save
    account2.save

    transaction = Transaction.new(amount: 10, description: "", account_id_target: account1.id, account_id_source: account2.id, account_num_target: account1.account_num, account_num_source: account1.account_num, fee: 8)
    assert_not transaction.save, "Saved transcation with same account num"
  end
  test "should not save a transaction without amount" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false, balance: 1000)
    account2 = Account.new(account_num: 98766, password: 2345, email: "teste2@email.com", vip: false,  balance: 1000)

    account1.save
    account2.save

    transaction = Transaction.new(description: "", account_id_target: account1.id, account_id_source: account2.id, account_num_target: account1.account_num, account_num_source: account2.account_num, fee: 8)
    assert_not transaction.save, "Saved transcation without amount"
  end
  test "should not save a transaction without fee" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false, balance: 1000)
    account2 = Account.new(account_num: 98766, password: 2345, email: "teste2@email.com", vip: false,  balance: 1000)

    account1.save
    account2.save

    transaction = Transaction.new(amount: 10, description: "", account_id_target: account1.id, account_id_source: account2.id, account_num_target: account1.account_num, account_num_source: account2.account_num)
    assert_not transaction.save, "Saved transcation without fee"
  end
end
