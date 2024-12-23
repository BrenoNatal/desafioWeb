require "test_helper"

class StatementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account = Account.create(account_num: 98765, password: 1234, email: "teste1@email.com", vip: false)
    sign_in @account
  end

  test "should get statements" do
    get statement_statement_url
    assert_response :success
  end
end
