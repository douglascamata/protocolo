#encoding: utf-8
require 'spec_helper'

describe Setor do
  context 'Criação de Setor' do
  	it 'Não deve existir dois setores com o mesmo nome' do 
    	Setor.create! nome: "Setor_1"
    	expect { Setor.create! nome: "Setor_1" }.to raise_error
	end
  end
end
