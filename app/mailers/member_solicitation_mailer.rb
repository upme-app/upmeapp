class MemberSolicitationMailer < ApplicationMailer

  def invite(member, project_owner, project)
    @member = member
    @project_owner = project_owner
    @project = project
    mail(to: @project_owner.email, subject: "Já tem #{@member.user_label} interessado(a) em atender a sua empresa! ")
  end

  def accept(member, project_owner, project)
    @member = member
    @project_owner = project_owner
    @project = project
    mail(to: @member.email, subject: "Seu perfil foi selecionado para atender a empresa #{project_owner.nome_empresa}!")
  end

  def refuse(member, project_owner, project)
    @member = member
    @project_owner = project_owner
    @project = project
    mail(to: @member.email, subject: "Infelizmente #{project_owner.nome_empresa} está procurando outro perfil de candidato para atendê-lo(a)!")
  end

end
