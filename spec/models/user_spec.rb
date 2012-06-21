require 'spec_helper'

describe User do
  describe "#admin?" do
    it "deve retornar true caso positivo" do
      user = create :user, role: 'admin'
      user.admin?.should be_true
    end
  end
end
