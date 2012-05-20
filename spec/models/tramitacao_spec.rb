#encoding: utf-8
require 'spec_helper'

describe Tramitacao do
  context 'criação' do
    it {should_not have_valid(:setor_origem).when(nil) }
    it {should_not have_valid(:setor_destino).when(nil) }
    it {should_not have_valid(:processo).when(nil) }
  end

  it 'registra recebimento' do
    tramitacao = create :tramitacao
    tramitacao.should_not be_recebida
    now = Time.now
    Timecop.freeze(now) { tramitacao.registrar_recebimento }
    tramitacao.should be_recebida
    tramitacao.recebida_em.should == now
  end

  it 'possui data/hora de envio como o momento da criacao' do
    tempo = Time.now
    processo = create :processo
    Timecop.freeze(tempo) do
      processo.enviar_para(create :setor)
    end
    processo.tramitacoes.last.enviada_em.should == tempo
  end
end
