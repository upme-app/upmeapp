class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum user_type: [:aluno, :professor, :empresa]
  has_many :user_area_de_interesse


  def update_areas_de_interesse(ar_nome_areas)
    user_area_de_interesse.destroy_all
    areas_selecionadas = AreaDeInteresse.where(name: ar_nome_areas)
    areas_selecionadas.each do |area_de_interesse|
      user_area_de_interesse.create(area_de_interesse_id: area_de_interesse.id)
    end
    save
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
