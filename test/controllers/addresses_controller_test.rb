require "test_helper"

class AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get addresses_url
    assert_response :success
    assert_select "label", "Enter your address:"
    assert_select "input#address"
  end
  
end
