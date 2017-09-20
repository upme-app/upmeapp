class MemberSolicitationMailer < ApplicationMailer

  def invite(member, project_owner)
    @member = member
    @project_owner = project_owner
    mail(to: @project_owner.email, subject: "#{@member.first_name} está interessado em seu projeto!")
  end

  def accept(member, project_owner)
    @member = member
    @project_owner = project_owner
    mail(to: @member.email, subject: 'Sua solicitação foi aceita!')
  end

  def refuse(member, project_owner)
    @member = member
    @project_owner = project_owner
    mail(to: @member.email, subject: 'Sua solicitação foi recusada!')
  end

end
