class TimelineStep < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  attr_accessor :skip_validation
  # relationships .............................................................
  belongs_to :project
  has_many :timeline_comments
  validates_presence_of :feedback,:note
  # validations ...............................................................
  validates_uniqueness_of :position, :scope => :project_id
  # callbacks .................................................................
  before_create :verify_position
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................

  def verify_position
    unless skip_validation
      max_position = TimelineStep.where(project_id: self.project_id).maximum("position")
      self.position = max_position + 1
    end
  end

  def self.init_project_steps(project)
    create_step(
        project,
        'Confirmação de Match',
        'Diagnóstico da situação da empresa, alinhamento de expectativas entre as partes, definição do escopo do projeto - o que vai ser entregue e como; briefing detalhado; definição sobre elaboração de contrato (se necessário), etc.',
        'Primeira reunião entre cliente e equipe realizada com sucesso - presencialmente ou via web.',
        Time.now + 2.weeks,
        1,
        true
    )
    create_step(
        project,
        'Desenvolvimento 1',
        'Brainstorm da equipe, definição das melhorias, principais pontos a serem trabalhados e start no desenvolvimento do projeto.',
        'Elaborar o diagnóstico com os detalhes a serem trabalhados. ',
        Time.now + 6.weeks,
        2,
        true
    )
    create_step(
        project,
        'Reunião intermediária',
        'Feedback do cliente sobre o diagnóstico, propor alterações e responder às demandas dos alunos. Pré-aprovação do esboço do projeto; referências; hora de tirar dúvidas e comunicar se existe algum documento ou informação faltando para a elaboração do projeto.',
        'Reunião realizada com sucesso.',
        Time.now + 7.weeks,
        3,
        true
    )
    create_step(
        project,
        'Desenvolvimento 2',
        'Seguir o desenvolvimento do projeto com as alterações propostas pelo cliente, com a documentação completa e as informações em dia.',
        'Conclusão do projeto.',
        Time.now + 11.weeks,
        4,
        true
    )
    create_step(
        project,
        'Entrega',
        'Apresentação final ao professor, realizar ajustes sugeridos e entregar o trabalho para cliente.',
        'Entrega do projeto pelo time e feedback do cliente',
        Time.now + 12.weeks,
        5,
        true
    )
  end

  def self.create_step(project, title, desc, entregavel, data_entrega, position, skip_validation)
    TimelineStep.create({
                            project_id: project.id,
                            title: title,
                            description: desc,
                            entregavel: entregavel,
                            entrega: data_entrega,
                            position: position,
                            skip_validation: skip_validation
                        })
  end

  # public instance methods ...................................................

  def finish(user,feedback,note)
    if user.can_finish_step?(project, self)
      update_attributes check_date: Time.now,feedback:feedback,note:note.to_i
    end
  end

  def entregue?
    return true unless check_date.nil?
    false
  end
  # protected instance methods ................................................
  # private instance methods ..................................................


end
