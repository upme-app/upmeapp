require 'rails_helper'

RSpec.describe User, type: :model do

  context do

    before do
      @student = create(:student)
      @client = create(:client)

      create(:project, user_id: @student.id)
      create(:project, user_id: @student.id)
      create(:project, user_id: @student.id)
      create(:project, user_id: @student.id).update_attribute(:started, true)

      create(:project, user_id: @client.id)
      create(:project, user_id: @client.id)
      create(:project, user_id: @client.id).update_attribute(:started, true)
    end

    it "user has projects" do
      expect(@student.my_projects.size).to eq(4)
      expect(@client.my_projects.size).to eq(3)
    end

    it "full name" do
      expect(@student.full_name).to eq('joao silva')
    end

    it "available projects" do
      expect(@student.available_projects.size).to eq(2)
      expect(@client.available_projects.size).to eq(3)
    end

  end

end
