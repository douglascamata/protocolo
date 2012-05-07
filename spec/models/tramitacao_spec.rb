#encoding: utf-8
require 'spec_helper'

describe Tramitacao do
  context 'criação' do
    
    it 'deve ter um setor de origem e destino e um ou mais requerimentos' do
      setor_destino = FactoryGirl.create :setor
      setor_origem = FactoryGirl.create :setor
      3.times{ FactoryGirl.create :requerimento, setor_origem: setor_origem}
      requerimentos = Requerimento.all

      FactoryGirl.create :tramitacao, setor_origem: setor_origem, setor_destino: setor_destino, 
                                      requerimentos: requerimentos

      Tramitacao.first.setor_origem.should == setor_origem
      Tramitacao.first.setor_destino.should == setor_destino
      Tramitacao.first.requerimentos.should == requerimentos
    end
  end
end
