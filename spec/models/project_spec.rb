require 'rails_helper'

RSpec.describe Project, type: :model do

  context "client create project" do

    before do
      @students = create_list(:student, 4)
      @client = create(:client)

      @project = create(:project, user_id: @client.id)
      @project.add_user @students[0]
      @project.add_user @students[1]

      @other_project = create(:project, user_id: @students[2].id)
      @other_project_b = create(:project, user_id: @students[1].id)
    end

    it 'project has users (2 students and 1 company)' do
      expect(@project.project_users.size).to eq(3)
    end

    it 'start project' do
      expect(@project.started).to be false
      @project.start
      expect(@project.started).to be true
    end

    it 'without client' do
      expect(@project.client.id).to eq(@client.id)
      expect(Project.without_client.size).to eq 2
    end

    it 'not started projects list' do
      expect(Project.not_started.size).to eq 3
      @project.start
      expect(Project.not_started.size).to be 2
    end

    it 'not deleted list' do
      expect(Project.not_deleted.size).to eq 3
      @project.update_attribute :deleted, true
      expect(Project.not_deleted.size).to be 2
    end

  end

end