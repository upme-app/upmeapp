class ClientSolicitationMailer < ApplicationMailer

  def invite(client, project_owner)
    @client = client
    @project_owner = project_owner
    mail(to: @project_owner.email, subject: "#{@client.nome_empresa} está interessado em seu projeto!")
  end

  def accept(client, project_owner)
    @client = client
    @project_owner = project_owner
    mail(to: @client.email, subject: 'Sua solicitação foi aceita!')
  end

  def refuse(client, project_owner)
    @client = client
    @project_owner = project_owner
    mail(to: @client.email, subject: 'Sua solicitação foi recusada!')
  end

end
