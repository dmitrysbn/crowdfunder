require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "email must be unique" do
    user = create(:user, email: "bettymaker@gmail.com")
    user2 = build(:user, email: "bettymaker@gmail.com")
    refute user2.valid?
  end

  test "user must include password_confirmation on create" do
    user = build(:user, password_confirmation: nil)
    refute user.valid?
  end

  test "password must match confirmation" do
    user = build(:user, password: "12345678", password_confirmation: "987654321")
    refute user.valid?
  end

  test "password must be at least 8 characters long" do
    user = build(:user, password: "12345", password_confirmation: "12345")
    refute user.valid?
  end

  test "pledged_amount returns total amount pledged by user" do
    user = create(:user)
    project1 = create(:project)
    project2 = create(:project)
    pledge1 = create(:pledge, user: user, project: project1, dollar_amount: 100)
    pledge2 = create(:pledge, user: user, project: project2, dollar_amount: 25)

    assert_equal(user.pledged_amount, 125)
  end

  test "full_name returns full name" do
    user = build(:user)
    assert_equal("Betty Maker", user.full_name)
  end

  test "pledged_for(project) returns total pledged by user to project" do
    user = create(:user)
    project = create(:project)
    pledge1 = create(:pledge, user: user, project: project, dollar_amount: 100)
    pledge2 = create(:pledge, user: user, project: project, dollar_amount: 25)
    pledge3 = create(:pledge, user: user, project: project, dollar_amount: 50)

    assert_equal(user.pledged_for(project), "175.00")
  end

end
