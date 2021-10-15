require 'test_helper'

class ForumthreadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @forumthread = forumthreads(:one)
  end

  test "should get index" do
    get forumthreads_url
    assert_response :success
  end

  test "should get new" do
    get new_forumthread_url
    assert_response :success
  end

  test "should create forumthread" do
    assert_difference('Forumthread.count') do
      post forumthreads_url, params: { forumthread: { replycount: @forumthread.replycount, title: @forumthread.title } }
    end

    assert_redirected_to forumthread_url(Forumthread.last)
  end

  test "should show forumthread" do
    get forumthread_url(@forumthread)
    assert_response :success
  end

  test "should get edit" do
    get edit_forumthread_url(@forumthread)
    assert_response :success
  end

  test "should update forumthread" do
    patch forumthread_url(@forumthread), params: { forumthread: { replycount: @forumthread.replycount, title: @forumthread.title } }
    assert_redirected_to forumthread_url(@forumthread)
  end

  test "should destroy forumthread" do
    assert_difference('Forumthread.count', -1) do
      delete forumthread_url(@forumthread)
    end

    assert_redirected_to forumthreads_url
  end
end
