class ClientSolicitation < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validate :invitation_already_exists

  def invitation_already_exists
    if ClientSolicitation.where(project_id: project_id).where(user_id: user_id).size > 0
      errors.add(:invitation_already_exists, 'Convite já enviado.')
    end
  end

  def self.solicitation_exists(project, user)
    ClientSolicitation.where(project_id: project.id).where(user_id: user.id).size > 0
  end

end
