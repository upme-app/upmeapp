class MemberSolicitation < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validate :solicitation_already_exists

  def self.new_solicitation(current_user, project, message)
    MemberSolicitation.new({
      user_id: current_user.id,
      project_id: project.id,
      message: message
    })
  end

  def accept(current_user)
    if project.user_id == current_user.id
      project.add_user(self.user)
      project.start
      Thread.new { MemberSolicitation.accept(current_user, project.user).deliver }
      self.destroy
    end
  end

  def refuse(current_user)
    if project.user_id == current_user.id
      Thread.new { MemberSolicitation.refuse(current_user, project.user).deliver }
      self.destroy
    end
  end

  def solicitation_already_exists
    if MemberSolicitation.where(project_id: project_id).where(user_id: user_id).size > 0
      errors.add(:invitation_already_exists, 'Convite já enviado.')
    end
  end

  def self.solicitation_exists(project, user)
    MemberSolicitation.where(project_id: project.id).where(user_id: user.id).size > 0
  end

end
