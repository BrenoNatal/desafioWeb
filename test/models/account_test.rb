require "test_helper"

class AccountTest < ActiveSupport::TestCase
  test "should allow to create account" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false)
    assert account1.save, "Não salvou a conta com todos os campos"
  end
  test "should not allow empty account_num" do
    account1 = Account.create(password: 1234, email: "teste1@email.com", vip: false)
    assert_not account1.save, "Salvou a conta sem numero de conta"
  end
  test "should not allow empty password" do
    account1 = Account.create(account_num: 98765, email: "teste1@email.com", vip: false)
    assert_not account1.save, "Salvou a conta sem senha"
  end
  test "should not allow empty email" do
    account1 = Account.create(account_num: 98765, password: 1234, vip: false)
    assert_not account1.save, "Salvou a conta com email vazio"
  end
  test "should not allow empty vip" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com")
    assert_not account1.save, "Salvou a conta com vip vazio"
  end
  test "should not allow duplicate account_num" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false)
    account2 = Account.new(account_num: 98765, password: 2345, email: "teste2@email.com", vip: false)
    account1.save
    assert_not account2.save, "Saved a duplicate account num"
  end
  test "should not allow duplicate email" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false)
    account2 = Account.new(account_num: 98766, password: 2345, email: "teste1@email.com", vip: false)
    account1.save
    assert_not account2.save, "Saved a duplicate account num"
  end
end
