# encoding: utf-8

require 'spec_helper'

describe Requerimento do
  context 'criação' do 
    it 'Retorna o numero do protocolo no formato 99999/ANO' do
        for n in 1..9 do
          FactoryGirl.create(:requerimento).numero_protocolo.should == "0000#{n}/12"
        end
        FactoryGirl.create(:requerimento).numero_protocolo.should == "00010/12"
    end
  end

  context 'ações de classe' do
    it 'deve retornar os requerimentos filtrados por setor de origem' do
      setor1 = FactoryGirl.create :setor
      setor2 = FactoryGirl.create :setor
      setor3 = FactoryGirl.create :setor
      3.times{FactoryGirl.create :requerimento, setor_origem: setor1, destino_inicial: setor3}
      3.times{FactoryGirl.create :requerimento, setor_origem: setor2, destino_inicial: setor3}

      Requerimento.filtrados_por_setor.should == {setor1 => Requerimento.first(3), setor2 => Requerimento.last(3), setor3 => []}
    end
  end

  context 'relações' do
    it 'Requerimento pode ou não ter varias tramitações' do
      should have_valid(:tramitacoes).when([])

      requerimento = FactoryGirl.create :requerimento
      requerimento.tramitacoes.build.should_not be_nil
    end
  end
end
