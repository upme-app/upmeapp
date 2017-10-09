require 'rails_helper'

RSpec.describe Project, type: :model do

  context 'user' do

    before do
      @students = create_list(:student, 4)
      @client = create(:client)

      @project = create(:project, user_id: @client.id)
      @project.add_user @students[0]
    end

    it 'user already in project' do
      result = @project.invite_email(@students[0].email, @students[0])
      expect(result).to eql(:user_already_in_project)
    end

    it 'invite existing user' do
      result = @project.invite_email(@students[1].email, @students[0])
      expect(result).to eql(:success)

      result = @project.invite_email(@students[1].email, @students[0])
      expect(result).to eql(:already_sent)
    end

    it 'invite not existing user' do
      result = @project.invite_email('foo@bar.com', @students[0])
      expect(result).to eql(:success)

      result = @project.invite_email('foo@bar.com', @students[0])
      expect(result).to eql(:already_sent)
    end

    it 'invite invalid email' do
      result = @project.invite_email('foobar', @students[0])
      expect(result).to eql(:invalid_email)
    end

  end


end