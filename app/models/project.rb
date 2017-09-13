class Project < ApplicationRecord

  has_many :project_users
  has_many :timeline_steps
  has_many :client_solicitations

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

  def self.without_client
    Project.where(client_id: nil)
  end

  def has_user(user)
    ProjectUser.where(project_id: id).where(user_id: user.id).size > 0
  end

  private

  def add_creator_user
    add_user(User.find(user_id))
  end

end
