class TimelineComment < ApplicationRecord
  belongs_to :user
  belongs_to :timeline_step
end
