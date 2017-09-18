require 'rails_helper'

RSpec.describe User, type: :model do

  context "with 3 projects" do

    before do
      @student = User.create({
        first_name: 'joao',
        last_name: 'silva',
        email: 'test@test.com',
        password: '123456',
        user_type: :aluno
      })

      @company = User.create({
        first_name: 'maria',
        last_name: 'lima',
        email: 'test@empresa.com',
        password: '123456',
        user_type: :empresa
      })

      Project.create({user_id: @student.id})
      Project.create({user_id: @student.id})
      Project.create({user_id: @student.id})
      Project.create({user_id: @student.id}).update_attribute(:started, true)

      Project.create({user_id: @company.id})
      Project.create({user_id: @company.id})
      Project.create({user_id: @company.id}).update_attribute(:started, true)
    end

    it "user has 3 projects" do
      expect(@student.my_projects.size).to eq(4)
      expect(@company.my_projects.size).to eq(3)
    end

    it "full name" do
      expect(@student.full_name).to eq('joao silva')
    end

    it "available projects" do
      expect(@student.available_projects.size).to eq(2)
      expect(@company.available_projects.size).to eq(3)
    end

  end



end
