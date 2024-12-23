require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false, balance: 1000)
    @account_vip = Account.create(account_num: 76543, password: 1234, email: "vip@email.com", vip: true)
    sign_in @account
    sign_in @account_vip
    @transaction = transactions(:one)
  end

  test "should get index" do
    get transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_transaction_url
    assert_response :success
  end

  test "should create transaction and the balance of accounts involded should be changed with right amount fee normal account" do
    account_balance_before = @account.balance
    vip_account_balance_before = @account_vip.balance
    assert_difference("Transaction.count") do
      post transactions_url, params: { transaction: { account_id_source: @account.id, account_num_source: @account.account_num, account_num_target: @account_vip.account_num, amount: @transaction.amount, description: @transaction.description } }
    end
    @account.reload
    @account_vip.reload

    assert_equal account_balance_before - @transaction.amount - 8, @account.balance
    assert_equal vip_account_balance_before + @transaction.amount, @account_vip.balance

    assert_redirected_to transaction_url(Transaction.last)
  end
  test "should create transaction and the balance of accounts involded should be changed with right amount fee vip account" do
    account_balance_before = @account.balance
    vip_account_balance_before = @account_vip.balance
    assert_difference("Transaction.count") do
      post transactions_url, params: { transaction: { account_id_source: @account_vip.id, account_num_source: @account_vip.account_num, account_num_target: @account.account_num, amount: @transaction.amount, description: @transaction.description } }
    end
    @account.reload
    @account_vip.reload

    assert_equal vip_account_balance_before - @transaction.amount - (@transaction.amount * 0.008), @account_vip.balance
    assert_equal account_balance_before + @transaction.amount, @account.balance

    assert_redirected_to transaction_url(Transaction.last)
  end
  test "should not create transaction if accunt_num is the same" do
    account_balance_before = @account.balance
    vip_account_balance_before = @account_vip.balance
    assert_no_difference("Transaction.count") do
      post transactions_url, params: { transaction: { account_id_source: @account_vip.id, account_num_source: @account_vip.account_num, account_num_target: @account_vip.account_num, amount: @transaction.amount, description: @transaction.description } }
    end
    @account.reload
    @account_vip.reload

    assert_equal vip_account_balance_before, @account_vip.balance
    assert_equal account_balance_before, @account.balance

    assert_response :unprocessable_entity
  end
  test "should not create transaction if amount is negative" do
    account_balance_before = @account.balance
    vip_account_balance_before = @account_vip.balance
    assert_no_difference("Transaction.count") do
      post transactions_url, params: { transaction: { account_id_source: @account_vip.id, account_num_source: @account_vip.account_num, account_num_target: @account.account_num, amount: -1, description: @transaction.description } }
    end
    @account.reload
    @account_vip.reload

    assert_equal vip_account_balance_before, @account_vip.balance
    assert_equal account_balance_before, @account.balance

    assert_response :unprocessable_entity
  end
end
