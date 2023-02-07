require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get help_path
    assert_select "title", full_title("Help")
    get login_path
    assert_select "title", full_title("Log In")
    get signup_path
    assert_select "title", full_title("Sign Up")
    get about_path
    assert_select "title", full_title("About")
    get contact_path
    assert_select "title", full_title("Contact")
    log_in_as(@user)
    get users_path
    assert_select "title", full_title("All Users")
    get user_path(@user)
    assert_select "title", full_title(@user.name)
    get user_path(@other_user)
    assert_select "title", full_title(@other_user.name)
    get edit_user_path(@user)
    assert_select "title", full_title("Edit User")
    get edit_user_path(@other_user)
    assert_redirected_to root_url
    delete logout_path
    assert_redirected_to root_url
    get users_path
    assert_redirected_to login_path
    get edit_user_path(@user)
    assert_redirected_to login_path
  end
end
