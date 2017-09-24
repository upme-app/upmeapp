class ProjectInvitationMailer < ApplicationMailer

  def invite(member, project_owner, project)
    @member = member
    @project_owner = project_owner
    @project = project
    mail(to: @member.email, subject: "#{@project_owner.first_name} quer que você faça parte do projeto #{@project.title}.")
  end

  def accept(member, project_owner, project)
    @member = member
    @project_owner = project_owner
    @project = project
    mail(to: @project_owner.email, subject: "#{@member.first_name} aceitou fazer parte do seu time.")
  end

  def refuse(member, project_owner, project)
    @member = member
    @project_owner = project_owner
    @project = project
    mail(to: @project_owner.email, subject: "#{@member.first_name} recusou fazer parte do seu time.")
  end

end
