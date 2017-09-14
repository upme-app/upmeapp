require "rails_helper"

RSpec.describe User, type: :model do

  describe '' do

    before do
      #@user_a = User.create(first_name: 'User a')
      #@user_b = User.create(first_name: 'User b')
      #@user_c = User.create(first_name: 'User c')
#
      #puts @user_a.inspect
#
      #@project_a = Project.create(title: 'Plano de Marketing')
      #@project_a.add_user(@user_a)
      #@project_a.add_user(@user_b)
      #@project_a.add_user(@user_c)
#
      #@project_b = Project.create(title: 'Desenvolvimento de Software')
      #@project_a.add_user(@user_b)
      #@project_a.add_user(@user_c)
    end

    # projetos que o usuário é membro
    it "user projects" do
      expect(true).to be true
    end

    # convites que ele pode aceitar para virar um membro
    it "user invitations" do
      expect(true).to be true

    end

    # se o usuario pode comentar em uma timeline
    it "user can timeline comment" do
      expect(true).to be true

    end

  end


end
