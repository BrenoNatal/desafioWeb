require "test_helper"

class DepositsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false)
    sign_in @account
    @deposit = deposits(:one)
  end

  test "should get new" do
    get new_deposit_url
    assert_response :success
  end

  test "should create deposit and increse account balance" do
    assert_difference("Deposit.count") do
      post deposits_url, params: { deposit: { amount: @deposit.amount, account_id: @account.id } }
    end
    @account.reload

    assert_equal @deposit.amount, @account.balance
    assert_redirected_to deposit_url(Deposit.last)
  end
  test "should not create a deposit with a negative amount and should not increase the account balance" do
    balance_before = @account.balance
    assert_no_difference("Deposit.count") do
      post deposits_url, params: { deposit: { amount: -1, account_id: @account.id } }, as: :json
    end
    @account.reload

    assert_equal balance_before, @account.balance
    assert_response :unprocessable_entity
  end
  test "should not create a deposit with a nil amount and should not increase the account balance" do
    balance_before = @account.balance
    assert_no_difference("Deposit.count") do
      post deposits_url, params: { deposit: { amount: nil, account_id: @account.id } }, as: :json
    end
    @account.reload

    assert_equal balance_before, @account.balance
    assert_response :unprocessable_entity
  end
  test "should not create a deposit with a nil account" do
    assert_no_difference("Deposit.count") do
      post deposits_url, params: { deposit: { amount: @deposit.amount, account_id: nil } }, as: :json
    end

    assert_response :unprocessable_entity
  end
end
