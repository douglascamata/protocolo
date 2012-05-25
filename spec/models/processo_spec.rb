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

  context 'workflow' do
    let(:processo) { create :processo }

    it 'possui estado inicial "criado"' do
      processo.estado.should == 'criado'
    end

    context 'criado' do
      it 'ao ser enviado, vai para "enviado"' do
        expect { processo.enviar_para!(create :setor) }.
          to change { processo.estado }.from('criado').to('enviado')
      end

      it 'nao pode ser recebido' do
        expect { processo.receber! }.to raise_error
      end
    end

    context "encerrado" do
      before(:each) do
        processo.enviar_para!(create :setor)
        processo.receber!
      end

      it "vindo de recebido, vai para 'encerrado' " do
        expect { processo.encerrar! }.
          to change { processo.estado }.from('recebido').to('encerrado')
      end

      it "não muda de estado" do
        processo.encerrar!
        expect { processo.receber! }.to raise_error
        expect { processo.enviar_para!( create :setor ) }.to raise_error
      end
    end
  end

  context 'ações de classe' do
    it 'deve retornar os processos filtrados por setor de atual' do
      setor1 = create :setor
      setor2 = create :setor
      setor3 = create :setor

      array_processos_setor1 = []
      array_processos_setor2 = []

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

    it 'retorna processos aguardando recebimento em determinado setor' do
      setor1, setor2 = create(:setor), create(:setor)
      processo1 = criar_processo_enviado_para(setor1)
      processo2 = criar_processo_enviado_para(setor1)
      processo3 = criar_processo_enviado_para(setor2)
      Processo.aguardando_recebimento_em(setor1).should =~ [processo1, processo2]
      Processo.aguardando_recebimento_em(setor2).should == [processo3]
    end
  end

  it 'retorna ultima tramitação' do
    processo = build :processo
    processo.tramitacoes << (ultima = stub_model(Tramitacao, enviada_em: 2.minutes.from_now))
    processo.tramitacoes << stub_model(Tramitacao, enviada_em: Time.now)
    processo.tramitacoes << stub_model(Tramitacao, enviada_em: 2.minutes.ago)
    processo.ultima_tramitacao.should == ultima
  end

  describe 'enviar processo' do
    before(:each) do
      @processo = create :processo
      @processo.setor_atual.should == @processo.setor_origem
      @setor_destino = create :setor
      @processo.should have(0).tramitacoes
      @processo.enviar_para(@setor_destino)
    end

    it 'gera uma tramitação' do
      @processo.should have(1).tramitacoes
    end

    it 'o setor atual passa a ser o setor destino do envio' do
      @processo.setor_atual.should == @setor_destino
    end
  end

  describe "encerrar" do
    before(:each) do
      @processo = create :processo
      @setor_destino = create :setor
      @processo.enviar_para(@setor_destino)
      @processo.receber!
      no_ano_e_hr(2013,5,10,15){ @processo.encerrar! }
      @processo.estado.should == 'encerrado'
    end

    it "guardar a data e hr de encerramento" do
      no_ano_e_hr(2013,5,10,15){ @processo.data_hr_encerramento.should == '01/01/13 - 05:10:15' }
    end

    it "guarda setor onde o processo foi encerrado" do
      @processo.setor_de_arquivamento.should == @setor_destino
    end
  end
end
