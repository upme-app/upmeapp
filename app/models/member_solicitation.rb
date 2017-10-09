class MemberSolicitation < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validate :solicitation_already_exists
  validate :not_empresa

  def self.new_solicitation(user, project, message)
    MemberSolicitation.new({
      user_id: user.id,
      project_id: project.id,
      message: message
    })
  end

  def accept(current_user)
    if project.user_id == current_user.id
      project.add_user(self.user)
      project.start
      Thread.new { MemberSolicitationMailer.accept(user, project.user, project).deliver }
      self.destroy
    end
  end

  def refuse(current_user)
    if project.user_id == current_user.id
      Thread.new { MemberSolicitationMailer.refuse(user, project.user, project).deliver }
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

  def not_empresa
    if user.empresa?
      errors.add(:not_empresa, 'Empresa não pode participar de um projeto de uma empresa')
    end
  end

end
