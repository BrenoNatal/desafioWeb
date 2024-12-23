require "test_helper"

class WithdrawalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false, balance: 1000)
    @account_vip = Account.create(account_num: 76543, password: 1234, email: "vip@email.com", vip: true)
    sign_in @account
    sign_in @account_vip
    @withdrawal = withdrawals(:one)
  end

  test "should get new" do
    get new_withdrawal_url
    assert_response :success
  end

  test "should create withdrawal if normal account balance is greater than amount" do
    balance_before = @account.balance
    assert_difference("Withdrawal.count") do
      post withdrawals_url, params: { withdrawal: { amount: @withdrawal.amount, account_id: @account.id  } }
    end
    @account.reload
    assert_equal balance_before - @withdrawal.amount, @account.balance

    assert_redirected_to withdrawal_url(Withdrawal.last)
  end
  test "should create withdrawal if vip account balance is less than withdrawa and decrese account balancel" do
    balance_before = @account_vip.balance
    assert_difference("Withdrawal.count") do
      post withdrawals_url, params: { withdrawal: { amount: @withdrawal.amount, account_id: @account_vip.id  } }
    end
    @account_vip.reload

    assert_equal balance_before - @withdrawal.amount, @account_vip.balance

    assert_redirected_to withdrawal_url(Withdrawal.last)
  end
  test "should not create a withdrawal with a nil amount and should not decrease the account balance" do
    balance_before = @account.balance
    assert_no_difference("Withdrawal.count") do
      post withdrawals_url, params: { withdrawal: { amount: nil, account_id: @account.id } }, as: :json
    end
    @account.reload

    assert_equal balance_before, @account.balance
    assert_response :unprocessable_entity
  end
  test "should not create a withdrawal with a nil account" do
    assert_no_difference("Withdrawal.count") do
      post withdrawals_url, params: { withdrawal: { amount: @withdrawal.id, account_id: nil } }, as: :json
    end


    assert_response :unprocessable_entity
  end
end
