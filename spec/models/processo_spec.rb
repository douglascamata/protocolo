# encoding: utf-8

require 'spec_helper'

describe Processo do
  context 'criação' do
    it 'Retorna o numero do protocolo no formato 99999/ANO' do
        for n in 1..9 do
          FactoryGirl.create(:processo).numero_protocolo.should == "0000#{n}/12"
        end
        FactoryGirl.create(:processo).numero_protocolo.should == "00010/12"
    end
  end

  context 'ações de classe' do
    it 'deve retornar os processos filtrados por setor de atual' do
      setor1 = FactoryGirl.create :setor
      setor2 = FactoryGirl.create :setor
      setor3 = FactoryGirl.create :setor

      array_processos_setor1 = []
      array_processos_setor2 = []
      array_processos_setor3 = []

      3.times{ array_processos_setor1 << FactoryGirl.create(:processo, setor_origem: setor1, destino_inicial: setor3)}
      3.times{ array_processos_setor2 << FactoryGirl.create(:processo, setor_origem: setor2, destino_inicial: setor3)}

      Processo.filtrados_por_setor.should == {setor1 => array_processos_setor1, setor2 => array_processos_setor2, setor3 => []}

      processo = FactoryGirl.create(:processo, setor_origem: setor1, destino_inicial: setor3)
      Processo.filtrados_por_setor[setor1].should include processo

      processo.tramitacoes.create(setor_origem: setor1, setor_destino: setor2)
      Processo.filtrados_por_setor[setor1].should_not include processo
      Processo.filtrados_por_setor[setor2].should include processo

      processo.tramitacoes.create(setor_origem: setor2, setor_destino: setor3)
      Processo.filtrados_por_setor[setor2].should_not include processo
      Processo.filtrados_por_setor[setor3].should include processo
    end
  end

  context 'relações' do
    it 'processo pode ou não ter varias tramitações' do
      should have_valid(:tramitacoes).when([])

      processo = FactoryGirl.create :processo
      processo.tramitacoes.build.should_not be_nil
    end

    it 'processo pode ou não ter varios despachos' do
      should have_valid(:despachos).when([])

      processo = FactoryGirl.create :processo
      processo.despachos.build.should_not be_nil
    end
  end
end
