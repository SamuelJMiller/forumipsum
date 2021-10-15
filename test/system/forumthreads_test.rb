require "application_system_test_case"

class ForumthreadsTest < ApplicationSystemTestCase
  setup do
    @forumthread = forumthreads(:one)
  end

  test "visiting the index" do
    visit forumthreads_url
    assert_selector "h1", text: "Forumthreads"
  end

  test "creating a Forumthread" do
    visit forumthreads_url
    click_on "New Forumthread"

    fill_in "Replycount", with: @forumthread.replycount
    fill_in "Title", with: @forumthread.title
    click_on "Create Forumthread"

    assert_text "Forumthread was successfully created"
    click_on "Back"
  end

  test "updating a Forumthread" do
    visit forumthreads_url
    click_on "Edit", match: :first

    fill_in "Replycount", with: @forumthread.replycount
    fill_in "Title", with: @forumthread.title
    click_on "Update Forumthread"

    assert_text "Forumthread was successfully updated"
    click_on "Back"
  end

  test "destroying a Forumthread" do
    visit forumthreads_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Forumthread was successfully destroyed"
  end
end
