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
    it 'deve retornar os requerimentos filtrados por setor de atual' do
      setor1 = FactoryGirl.create :setor
      setor2 = FactoryGirl.create :setor
      setor3 = FactoryGirl.create :setor
      
      array_requerimentos_setor1 = []
      array_requerimentos_setor2 = []
      array_requerimentos_setor3 = []

      3.times{ array_requerimentos_setor1 << FactoryGirl.create(:requerimento, setor_origem: setor1, destino_inicial: setor3)}
      3.times{ array_requerimentos_setor2 << FactoryGirl.create(:requerimento, setor_origem: setor2, destino_inicial: setor3)}

      Requerimento.filtrados_por_setor.should == {setor1 => array_requerimentos_setor1, setor2 => array_requerimentos_setor2, setor3 => []}
      
      requerimento = FactoryGirl.create(:requerimento, setor_origem: setor1, destino_inicial: setor3)
      Requerimento.filtrados_por_setor[setor1].should include requerimento

      requerimento.tramitacoes.create(setor_origem: setor1, setor_destino: setor2)
      Requerimento.filtrados_por_setor[setor1].should_not include requerimento
      Requerimento.filtrados_por_setor[setor2].should include requerimento

      requerimento.tramitacoes.create(setor_origem: setor2, setor_destino: setor3)
      Requerimento.filtrados_por_setor[setor2].should_not include requerimento
      Requerimento.filtrados_por_setor[setor3].should include requerimento
    end
  end

  context 'relações' do
    it 'Requerimento pode ou não ter varias tramitações' do
      should have_valid(:tramitacoes).when([])

      requerimento = FactoryGirl.create :requerimento
      requerimento.tramitacoes.build.should_not be_nil
    end

    it 'Requerimento pode ou não ter varios despachos' do
      should have_valid(:despachos).when([])

      requerimento = FactoryGirl.create :requerimento
      requerimento.despachos.build.should_not be_nil
    end
  end
end
