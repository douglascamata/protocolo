# encoding: utf-8

require 'spec_helper'

describe Requerimento do
  it 'Retorna o numero do protocolo no formato 99999/ANO' do
    for n in 1..9 do
      Requerimento.gerar_numero_protocolo.should == "0000#{n}/12"
      FactoryGirl.create :requerimento
    end
  end
end

