json.extract! project_event, :id, :project_id, :user_id, :title, :description, :start_date, :end_date, :created_at, :updated_at
json.url project_event_url(project_event, format: :json)
