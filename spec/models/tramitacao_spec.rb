#encoding: utf-8
require 'spec_helper'

describe Tramitacao do
  context 'criação' do
    it {should_not have_valid(:setor_origem).when(nil) }
    it {should_not have_valid(:setor_destino).when(nil) }
    it {should_not have_valid(:requerimentos).when([]) }
  end
end
