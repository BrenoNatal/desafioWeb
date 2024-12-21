require "test_helper"

class ServiceTest < ActiveSupport::TestCase
  test "should not allow a non vip account to use a service" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false, balance: 1000)
    account1.save
    service = Service.new(service_type: "Visita", amount: 50, account_id: account1.id)
    assert_not service.save, "Non vip account used a service"
  end
  test "should not save a service without amount" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: true, balance: 1000)
    account1.save
    service = Service.new(service_type: "Visita", account_id: account1.id)
    assert_not service.save, "Saved service without amount"
  end
  test "should not save a service without type" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: true, balance: 1000)
    account1.save
    service = Service.new(amount: 50, account_id: account1.id)
    assert_not service.save, "Saved service without type"
  end
  test "should not save a service if account can't pay" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: true, balance: 10)
    account1.save
    service = Service.new(service_type: "Visita", amount: 50, account_id: account1.id)
    assert_not service.save, "Saved service with account that can't pay"
  end
  test "should save a service if all conditions are fulfilled" do
    account1 = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: true, balance: 1000)
    account1.save
    service = Service.new(service_type: "Visita", amount: 50, account_id: account1.id)
    assert service.save, "Didn't save service with all conditions"
  end
end
