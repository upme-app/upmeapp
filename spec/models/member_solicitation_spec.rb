require 'rails_helper'

RSpec.describe MemberSolicitation, type: :model do

  context 'cliente criou projeto e deve receber solicitações de alunos e professores' do

    before do
      @student = create(:student)
      @client = create(:client)
      @other_client = create(:client)
      @project = create(:project, user_id: @client.id)
      @student_solicitation = MemberSolicitation.new_solicitation(@student, @project, 'foo')
      @client_solicitation = MemberSolicitation.new_solicitation(@client, @project, 'foo')
    end

    it 'estudante envia solicitação' do
      expect(@student_solicitation.save).to be(true)
    end

    it 'cliente envia a solicitação' do
      expect(@client_solicitation.save).to be(false)
    end

    it 'solicitação já existe' do
      expect(@student_solicitation.save).to be(true)
      identical_solicitation = MemberSolicitation.new_solicitation(@student, @project, 'foo')
      expect(identical_solicitation .save).to be(false)
    end
  end

  context 'solicitações enviadas podem ser aceitas e recusadas' do
    before do
      @student = create(:student)
      @client = create(:client)
      @project = create(:project, user_id: @client.id)
      @student_solicitation = MemberSolicitation.new_solicitation(@student, @project, 'foo')
      @student_solicitation.save
    end

    it 'aceitar' do

    end

    it 'apenas o dono do projeto pode recusar' do
      expect(MemberSolicitation.all.size).to eql(1)
      @student_solicitation.refuse(@student)
      expect(MemberSolicitation.all.size).to eql(1)
      @student_solicitation.refuse(@client)
      expect(MemberSolicitation.all.size).to eql(0)
    end

  end


end
