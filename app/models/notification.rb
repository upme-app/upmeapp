class Notification < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include Rails.application.routes.url_helpers
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :user
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................

  # project invitation

  def self.project_invitation(user_from, user_to)
    desc = "#{user_from.first_name} te convidou para um projeto."
    url = Rails.application.routes.url_helpers.projects_path.to_s
    user_to.add_notification(desc, url)
  end

  def self.accept_project_invitation(user_to, user_from, project)
    desc = "#{user_to.first_name} aceitou fazer parte do seu time."
    url = Rails.application.routes.url_helpers.project_path(project).to_s
    user_from.add_notification(desc, url)
  end

  def self.refuse_project_invitation(user_to, user_from, project)
    desc = "#{user_to.first_name} recusou fazer parte do seu time."
    url = Rails.application.routes.url_helpers.project_path(project).to_s
    user_from.add_notification(desc, url)
  end

  # member solicitation

  def self.invite_member_solicitation(member, project_owner, project)
    desc = "Já tem #{member.user_label} interessado(a) em atender a sua empresa! "
    url = Rails.application.routes.url_helpers.project_path(project).to_s
    project_owner.add_notification(desc, url)
  end

  def self.accept_member_solicitation(member, project_owner, project)
    desc = "Seu perfil foi selecionado para atender a empresa #{project_owner.nome_empresa}!"
    url = Rails.application.routes.url_helpers.project_path(project).to_s
    member.add_notification(desc, url)
  end

  def self.refuse_member_solicitation(member, project_owner, project)
    desc = "Infelizmente #{project_owner.nome_empresa} está procurando outro perfil de candidato para atendê-lo(a)!"
    url = Rails.application.routes.url_helpers.explore_path.to_s
    member.add_notification(desc, url)
  end

  # client solicitation

  def self.invite_client_solicitation(client, project_owner, project)
    desc = "Já tem cliente interessado na sua oferta!"
    url = Rails.application.routes.url_helpers.project_path(project).to_s
    project_owner.add_notification(desc, url)
  end

  def self.accept_client_solicitation(client, project_owner, project)
    desc = "Sua empresa foi selecionada para atender o projeto #{project.title}!"
    url = Rails.application.routes.url_helpers.project_path(project).to_s
    client.add_notification(desc, url)
  end

  def self.refuse_client_solicitation(client, project_owner, project)
    desc = "Infelizmente o projeto #{project.title} está procurando outro perfil de empresa para atendê-lo(a)!"
    url = Rails.application.routes.url_helpers.explore_path.to_s
    client.add_notification(desc, url)
  end
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
end
