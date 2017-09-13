class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum user_type: [:aluno, :professor, :empresa]
  has_many :user_area_de_interesse


  def update_areas_de_interesse(ar_nome_areas)
    user_area_de_interesse.destroy_all
    areas_selecionadas = AreaDeInteresse.where(name: ar_nome_areas)
    areas_selecionadas.each do |area_de_interesse|
      user_area_de_interesse.create(area_de_interesse_id: area_de_interesse.id)
    end
    save
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def my_projects
    Project.where(id: ProjectUser.where(user_id: id).pluck(:project_id))
  end

  def my_invitations
    ProjectInvitation.where(user_to_id: id)
  end

  def profile_is_complete?
    return false if city.blank?
    if aluno?
      return false if universidade.blank? or semestre.blank?
    end

    true
  end

  def can_timeline_comment?(project, step)
    project.has_user(self)
  end

end
