require 'spec_helper'

describe User do
  describe "#admin?" do
    it "deve retornar true caso positivo" do
      user = create :user, role: 'admin'
      user.admin?.should be_true
    end
  end

  describe "#solicitante?" do
    it "deve retornar true caso positivo" do
      create(:user_solicitante).solicitante?.should == true
      create(:user).solicitante?.should == false
    end
  end

  describe "#no_meu_setor?" do
    it "deve retornar se o processo pertence ao mesmo setor q o seu" do
      processo = create :processo
      user = create :user_solicitante
      setor = user.setores.first

      user.no_meu_setor?(processo).should == false

      user.solicitante.setores << processo.setor_origem
      user.no_meu_setor?(processo).should == true
    end
  end
end
