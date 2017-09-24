class ProjectInvitation < ApplicationRecord
  belongs_to :user_from, class_name: 'User'
  belongs_to :user_to, class_name: 'User'
  belongs_to :project

  validate :user_already_exists
  validate :invitation_already_exists

  def accept
    project.add_user(User.find(user_to_id))
    self.destroy
  end

  def refuse
    self.destroy
  end

  def user_already_exists
    if ProjectUser.where(project_id: project_id).where(user_id: user_to_id).size > 0
      errors.add(:user_already_exists, 'O usuário já foi convidado.')
    end
  end

  def invitation_already_exists
    if ProjectInvitation.where(project_id: project_id).where(user_to_id: user_to_id).size > 0
      errors.add(:invitation_already_exists, 'Convite já enviado.')
    end
  end

end
