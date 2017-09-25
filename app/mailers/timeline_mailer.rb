class TimelineMailer < ApplicationMailer

  def comment(quem_enviou, pra_quem, project)
    @quem_enviou = quem_enviou
    @pra_quem = pra_quem
    @project = project
    mail(to: @pra_quem.email, subject: "Você tem uma nova mensagem de #{@quem_enviou.first_name} na linha do tempo de seu projeto.")
  end

end
