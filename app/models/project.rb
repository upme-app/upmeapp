class Project < ApplicationRecord

  has_many :project_users

  after_create :add_creator_user

  def add_user(user)
    return false if ProjectUser.where(user_id: user.id).where(project_id: id).size > 0
    ProjectUser.create({
     project_id: id,
     user_id: user.id
    })
  end

  private

  def add_creator_user
    add_user(User.find(user_id))
  end

end
