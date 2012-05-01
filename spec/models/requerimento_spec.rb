# encoding: utf-8

require 'spec_helper'

describe Requerimento do
  it 'Retorna o numero do protocolo no formato 99999/ANO' do
    for n in 1..9 do
      FactoryGirl.create(:requerimento).numero_protocolo.should == "0000#{n}/12"
    end
    FactoryGirl.create(:requerimento).numero_protocolo.should == "00010/12"
  end
end
