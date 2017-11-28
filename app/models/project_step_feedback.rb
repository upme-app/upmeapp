class ProjectStepFeedback < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :timeline_step
end
