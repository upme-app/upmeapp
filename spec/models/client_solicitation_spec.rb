require 'rails_helper'

RSpec.describe ClientSolicitation, type: :model do

  context 'aluno/professor criou projeto e um cliente quer solicitar' do

    before do
      @student = create(:student)
      @client = create(:client)
      @project = create(:project, user_id: @student.id)
      @student_solicitation = ClientSolicitation.new_solicitation(@student, @project, 'foo')
      @client_solicitation = ClientSolicitation.new_solicitation(@client, @project, 'foo')
    end

    it 'cliente envia a solicitação' do
      expect(@client_solicitation.save).to be(true)
    end

    it 'estudante envia solicitação' do
      expect(@student_solicitation.save).to be(false)
    end

    it 'solicitação já existe' do
      expect(@client_solicitation.save).to be(true)
      identical_solicitation = ClientSolicitation.new_solicitation(@client, @project, 'foo')
      expect(identical_solicitation .save).to be(false)
    end
  end

  context 'solicitações enviadas podem ser aceitas e recusadas' do
    before do
      @student = create(:student)
      @client = create(:client)
      @project = create(:project, user_id: @student.id)
      @client_solicitation = ClientSolicitation.new_solicitation(@client, @project, 'foo')
      @client_solicitation.save
    end

    it 'aceitar' do

    end

    it 'apenas o dono do projeto pode recusar' do
      expect(ClientSolicitation.all.size).to eql(1)
      @client_solicitation.refuse(@client)
      expect(ClientSolicitation.all.size).to eql(1)
      @client_solicitation.refuse(@student)
      expect(ClientSolicitation.all.size).to eql(0)
    end

  end


end
