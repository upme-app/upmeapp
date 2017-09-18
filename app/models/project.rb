class Project < ApplicationRecord

  has_many :project_users
  has_many :timeline_steps
  has_many :client_solicitations
  has_many :member_solicitations

  belongs_to :user
  belongs_to :client, class_name: 'User'

  after_create :add_creator_user

  def add_user(user)
    return false if ProjectUser.where(user_id: user.id).where(project_id: id).size > 0
    ProjectUser.create({
      project_id: id,
      user_id: user.id
    })
  end

  def start
    update_attribute :started, true
    TimelineStep.init_project_steps self
  end

  def self.without_client
    Project.where(client_id: nil)
  end

  def self.not_started_projects
    Project.where(started: false)
  end

  def self.not_deleted
    Project.where(deleted: false)
  end

  def self.available_empresa_projects
    Project.joins(:user).not_deleted.not_started_projects.where('users.user_type != ?', User.user_types[:empresa])
  end

  def self.available_aluno_projects
    Project.joins(:user).not_deleted.not_started_projects.where('users.user_type = ?', User.user_types[:empresa])
  end

  def has_user(user)
    ProjectUser.where(project_id: id).where(user_id: user.id).size > 0
  end

  def can_be_deleted_by(user)
    true if deleted == false and user.id == user_id
  end

  def can_be_restored_by(user)
    true if deleted == true and user.id == user_id
  end

  private

  def add_creator_user
    add_user(self.user)
    if self.user.empresa?
      update_attribute :client_id, self.user.id
    end
  end

end
