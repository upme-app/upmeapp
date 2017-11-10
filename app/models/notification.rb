class Notification < ApplicationRecord

  include Rails.application.routes.url_helpers
  
  belongs_to :user

  def self.project_invitation(user_from, user_to)
    desc = "#{user_from.first_name} te convidou para um projeto." 
    url = Rails.application.routes.url_helpers.projects_path.to_s    
    user_to.add_notification(desc, url)
  end
end
