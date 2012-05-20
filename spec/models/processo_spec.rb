# encoding: utf-8

require 'spec_helper'

describe Processo do
  context 'criação' do
    it 'Retorna o numero do protocolo no formato 99999/ANO' do
        for n in 1..9 do
          create(:processo).numero_protocolo.should == "0000#{n}/12"
        end
        create(:processo).numero_protocolo.should == "00010/12"
    end
  end

  context 'ações de classe' do
    it 'deve retornar os processos filtrados por setor de atual' do
      setor1 = create :setor
      setor2 = create :setor
      setor3 = create :setor

      array_processos_setor1 = []
      array_processos_setor2 = []
      array_processos_setor3 = []

      3.times{ array_processos_setor1 << create(:processo, setor_origem: setor1, destino_inicial: setor3)}
      3.times{ array_processos_setor2 << create(:processo, setor_origem: setor2, destino_inicial: setor3)}

      Processo.filtrados_por_setor.should == {setor1 => array_processos_setor1, setor2 => array_processos_setor2, setor3 => []}

      processo = create(:processo, setor_origem: setor1, destino_inicial: setor3)
      Processo.filtrados_por_setor[setor1].should include processo

      processo.tramitacoes.create(setor_origem: setor1, setor_destino: setor2)
      Processo.filtrados_por_setor[setor1].should_not include processo
      Processo.filtrados_por_setor[setor2].should include processo

      processo.tramitacoes.create(setor_origem: setor2, setor_destino: setor3)
      Processo.filtrados_por_setor[setor2].should_not include processo
      Processo.filtrados_por_setor[setor3].should include processo
    end
  end
end
