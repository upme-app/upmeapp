class Project < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  has_many :project_users
  has_many :timeline_steps
  has_many :client_solicitations
  has_many :member_solicitations
  has_many :project_area_de_interesse
  belongs_to :user
  belongs_to :client, class_name: 'User'
  # validations ...............................................................
  # callbacks .................................................................
  after_create :add_creator_user
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................
  # public instance methods ...................................................


  def add_user(user)
    return false if ProjectUser.where(user_id: user.id).where(project_id: id).size > 0
    ProjectUser.create({
                           project_id: id,
                           user_id: user.id
                       })
  end

  def invite_email(email, from_user)
    user = User.find_by_email(email)
    if user
      invite_registered_user(user, from_user)
    else
      invite_not_registered_user(email, from_user)
    end
  end

  def start
    update_attribute :started, true
    TimelineStep.init_project_steps self
  end

  def self.without_client
    Project.where(client_id: nil)
  end

  def self.not_started
    Project.where(started: false)
  end

  def self.not_deleted
    Project.where(deleted: false)
  end

  def self.all_ofertas
    Project.joins(:user).not_deleted.not_started
      .where('users.user_type != ?', User.user_types[:empresa]).distinct
  end

  def self.all_demandas
    Project.joins(:user).not_deleted.not_started.
      where('users.user_type = ?', User.user_types[:empresa]).distinct
  end

  def self.projects_running
    Project.not_deleted.where(started: true)
  end

  def self.deleted_projects
    Project.where(deleted: true)
  end

  def has_user(user)
    ProjectUser.where(project_id: id).where(user_id: user.id).size > 0
  end

  def has_step(step)
    TimelineStep.find(step.id).project_id == self.id
  end

  def can_be_deleted_by(user)
    true if deleted == false and user.id == user_id
  end

  def can_be_restored_by(user)
    true if deleted == true and user.id == user_id
  end

  def ordered_timeline_steps
    timeline_steps.order(entrega: :asc)
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
  private

  def add_creator_user
    add_user(self.user)
    if self.user.empresa?
      update_attribute :client_id, self.user.id
    end

    update_attribute :deleted, false
    update_attribute :started, false
  end

  def invite_registered_user(user, from_user)
    return :user_already_in_project if has_user user
    return :already_sent if ProjectInvitation.where(project_id: id, user_to_id: user.id).size > 0

    invitation = ProjectInvitation.new({
                                           user_from_id: from_user.id,
                                           user_to_id: user.id,
                                           project_id: self.id
                                       })
    if invitation.save
      Notification.project_invitation(invitation.user_from, invitation.user_to)
      ProjectInvitationMailer.invite(invitation.user_to, invitation.user_from, self).deliver_later
      :success
    else
      :failed
    end
  end

  def invite_not_registered_user(email, from_user)
    return :failed if User.find_by_email(email)
    return :already_sent if InviteEmail.where(project_id: id, to_email: email).size > 0
    return :invalid_email unless email.match('[a-z0-9]+[_a-z0-9\.-]*[a-z0-9]+@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})')

    invitation = InviteEmail.new({
                                     user_id: from_user.id,
                                     project_id: self.id,
                                     completed: false,
                                     to_email: email,
                                     token: SecureRandom.uuid
                                 })

    if invitation.save
      ProjectInvitationMailer.invite_email(invitation.to_email, invitation.user, self, invitation.token).deliver_later
      :success
    else
      :failed
    end
  end
end
