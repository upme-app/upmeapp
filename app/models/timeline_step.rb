class TimelineStep < ApplicationRecord
  belongs_to :project

  def self.init_project_steps(project)
    create_step(
        project,
        'Etapa 1',
        'na etapa 1 vamos brincar de carrinho',
        'e vai ter que entregar td',
        Time.now + 1.month
    )

    create_step(
        project,
        'Etapa 2',
        'na etapa 1 vamos brincar de boneca',
        'e vai ter que entregar td',
        Time.now + 2.month
    )

    create_step(
        project,
        'Etapa 3',
        'cansei de brincar',
        'entregar sempre',
        Time.now + 3.month
    )

    create_step(
        project,
        'Etapa 4 sou adulto',
        'agr sou adulto',
        'entrega ou morre!',
        Time.now + 4.month
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
