require 'rails_helper'

RSpec.describe User, type: :model do

  context do

    before do
      @professor = create(:professor)
      @client = create(:client)

      create(:project, user_id: @professor.id)
      create(:project, user_id: @professor.id)
      create(:project, user_id: @professor.id)
      create(:project, user_id: @professor.id).update_attribute(:started, true)

      create(:project, user_id: @client.id)
      create(:project, user_id: @client.id)
      create(:project, user_id: @client.id).update_attribute(:started, true)
    end

    it "user has projects" do
      expect(@professor.my_projects.size).to eq(4)
      expect(@client.my_projects.size).to eq(3)
    end

    it "full name" do
      expect(@professor.full_name).to eq('joao prof silva prof')
    end

    it "available projects" do
      expect(@professor.available_projects.size).to eq(2)
      expect(@client.available_projects.size).to eq(3)
    end

  end

end
