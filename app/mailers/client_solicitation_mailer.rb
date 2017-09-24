class ClientSolicitationMailer < ApplicationMailer

  def invite(client, project_owner, project)
    @client = client
    @project_owner = project_owner
    @project = project
    mail(to: @project_owner.email, subject: "Já tem cliente interessado na sua oferta!")
  end

  def accept(client, project_owner, project)
    @client = client
    @project_owner = project_owner
    @project = project
    mail(to: @client.email, subject: "Sua empresa foi selecionada para atender o projeto #{@project.title}!")
  end

  def refuse(client, project_owner, project)
    @client = client
    @project_owner = project_owner
    @project = project
    mail(to: @client.email, subject: "Infelizmente o projeto #{@project.title} está procurando outro perfil de empresa para atendê-lo(a)!")
  end

end
