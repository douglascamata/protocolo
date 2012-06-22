# encoding: utf-8
require 'spec_helper'

feature "reabrir processo" do
  scenario 'autorização' do
    visit reabrir_processos_path
    page.should have_content 'Você não tem permissão para acessar esse conteudo.'
  end

  scenario 'processos encerrados devem ser mostrados relativamente ao setor selecionado', javascript: true do
    logar(create :user, role: 'admin')
    
    setor1 = create :setor, nome: 'Setor 1'
    no_ano(2012) do 
      2.times{ criar_processo_encerrado_em(setor1) } 
      criar_processo_encerrado_em(create :setor)
    end
    visit reabrir_processos_path

    select 'Setor 1', from: 'Setor'
    page.should have_content '00001/12'
    page.should have_content '00002/12'
    page.should_not have_content '00003/12'
  end
end