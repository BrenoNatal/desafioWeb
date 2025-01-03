require "application_system_test_case"

class WithdrawalsTest < ApplicationSystemTestCase
  setup do
    @withdrawal = withdrawals(:one)
  end

  test "visiting the index" do
    visit withdrawals_url
    assert_selector "h1", text: "Withdrawals"
  end

  test "should create withdrawal" do
    visit withdrawals_url
    click_on "New withdrawal"

    fill_in "Account", with: @withdrawal.account_id
    fill_in "Amount", with: @withdrawal.amount
    click_on "Create Withdrawal"

    assert_text "Withdrawal was successfully created"
    click_on "Back"
  end

  test "should update Withdrawal" do
    visit withdrawal_url(@withdrawal)
    click_on "Edit this withdrawal", match: :first

    fill_in "Account", with: @withdrawal.account_id
    fill_in "Amount", with: @withdrawal.amount
    click_on "Update Withdrawal"

    assert_text "Withdrawal was successfully updated"
    click_on "Back"
  end

  test "should destroy Withdrawal" do
    visit withdrawal_url(@withdrawal)
    click_on "Destroy this withdrawal", match: :first

    assert_text "Withdrawal was successfully destroyed"
  end
end
