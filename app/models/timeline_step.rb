class TimelineStep < ApplicationRecord
  belongs_to :project
  has_many :timeline_comments

  def self.init_project_steps(project)

    create_step(
        project,
        'Confirmação de Match',
        'Conheça sua equipe ou seu cliente, alinhe as expectativas, explique o escopo do projeto e confirme o match!',
        'Primeira reunião entre cliente e time realizada com sucesso.',
        Time.now + 2.weeks
    )

  end

  def self.create_step(project, title, desc, entregavel, data_entrega)
    TimelineStep.create({
      project_id: project.id,
      title: title,
      description: desc,
      entregavel: entregavel,
      entrega: data_entrega
    })
  end


end
