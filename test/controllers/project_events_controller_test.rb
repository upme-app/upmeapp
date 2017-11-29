require 'test_helper'

class ProjectEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project_event = project_events(:one)
  end

  test "should get index" do
    get project_events_url
    assert_response :success
  end

  test "should get new" do
    get new_project_event_url
    assert_response :success
  end

  test "should create project_event" do
    assert_difference('ProjectEvent.count') do
      post project_events_url, params: { project_event: { description: @project_event.description, end_date: @project_event.end_date, project_id: @project_event.project_id, start_date: @project_event.start_date, title: @project_event.title, user_id: @project_event.user_id } }
    end

    assert_redirected_to project_event_url(ProjectEvent.last)
  end

  test "should show project_event" do
    get project_event_url(@project_event)
    assert_response :success
  end

  test "should get edit" do
    get edit_project_event_url(@project_event)
    assert_response :success
  end

  test "should update project_event" do
    patch project_event_url(@project_event), params: { project_event: { description: @project_event.description, end_date: @project_event.end_date, project_id: @project_event.project_id, start_date: @project_event.start_date, title: @project_event.title, user_id: @project_event.user_id } }
    assert_redirected_to project_event_url(@project_event)
  end

  test "should destroy project_event" do
    assert_difference('ProjectEvent.count', -1) do
      delete project_event_url(@project_event)
    end

    assert_redirected_to project_events_url
  end
end
