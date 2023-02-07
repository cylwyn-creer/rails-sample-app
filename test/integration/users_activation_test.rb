require "test_helper"

class UsersActivationTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @inactive_user = User.create!(name: "Inavctive User",
                                  email: "inactive@example.com",
                                  password: "password")
  end

  test "index only displays activated users" do
    log_in_as(@user)
    get users_path
    first_page_of_users = User.where(activated: true).paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end

  test "should only show activated user profile, redirect to root otherwise" do
    get user_path(@inactive_user)
    assert_redirected_to root_url
  end
end
