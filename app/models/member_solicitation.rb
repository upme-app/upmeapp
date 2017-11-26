class MemberSolicitation < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :project
  belongs_to :user
  # validations ...............................................................
  validate :solicitation_already_exists
  validate :not_empresa
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................
  def self.new_solicitation(user, project, message)
    MemberSolicitation.new({
                               user_id: user.id,
                               project_id: project.id,
                               message: message
                           })
  end

  def self.solicitation_exists(project, user)
    MemberSolicitation.where(project_id: project.id).where(user_id: user.id).size > 0
  end

  # public instance methods ...................................................


  def accept(current_user)
    if project.user_id == current_user.id
      project.add_user(self.user)
      MemberSolicitationMailer.accept(user, project.user, project).deliver_later
      Notification.accept_member_solicitation(user, project.user, project)
      self.destroy
    end
  end

  def refuse(current_user)
    if project.user_id == current_user.id
      MemberSolicitationMailer.refuse(user, project.user, project).deliver_later
      Notification.refuse_member_solicitation(user, project.user, project)
      self.destroy
    end
  end

  def solicitation_already_exists
    if MemberSolicitation.where(project_id: project_id).where(user_id: user_id).size > 0
      errors.add(:invitation_already_exists, 'Convite já enviado.')
    end
  end

  def not_empresa
    if user.empresa?
      errors.add(:base, 'Empresa não pode participar de um projeto de uma empresa')
    end
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
