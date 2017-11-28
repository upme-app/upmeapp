class User < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  has_many :user_area_de_interesse
  has_many :notifications
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum user_type: [:aluno, :professor, :empresa]
  enum tipo_pessoa: [:fisica, :juridica]
  # class methods .............................................................
  # public instance methods ...................................................
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
    Project.where(id: ProjectUser.where(user_id: id).pluck(:project_id)).where(deleted: false)
  end

  def my_filed_projects
    Project.where(id: ProjectUser.where(user_id: id).pluck(:project_id)).where(deleted: true)
  end

  def my_invitations
    ProjectInvitation.where(user_to_id: id)
  end

  def profile_is_complete?
    return false if city.blank?
    if aluno?
      return false if universidade.blank? or semestre.blank?
    end

    if empresa?
      return false if nome_empresa.blank?
    end

    true
  end

  def billing_data_is_complete?
    return false if tipo_pessoa.blank? or cep.blank? or endereco.blank? or numero.blank? or uf.blank? or cidade.blank? or cpf.blank? or telefone.blank?
    true
  end

  def available_projects(project_areas_de_interesse=nil)
    if empresa?
      Project.all_ofertas
    else
      Project.all_demandas
    end
  end

  def can_timeline_comment?(project, step)
    project.has_user(self)
  end

  def can_finish_step?(project, step)
    project.has_user(self) and project.has_step(step) and project.client_id == self.id and !step.entregue?
  end

  def can_edit_step_entrega?(project, step)
    true if professor? and project.has_user(self) and project.has_step(step) and !step.entregue?
  end

  def can_edit_project?(projcet)
    true if professor? or empresa?
  end

  def user_label
    return 'aluno(a)' if aluno?
    return 'professor(a)' if professor?
    'empresa'
  end

  def add_notification(description, url)
    Notification.create({
                            user_id: self.id,
                            url: url,
                            description: description
                        })
  end

  def unread_notifications_size
    notifications.reject {|n| n.read == true}.size
  end
  # protected instance methods ................................................
  # private instance methods ..................................................

end
