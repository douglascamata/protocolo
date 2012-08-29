# encoding: utf-8
require 'spec_helper'

feature "reabrir processo" do
  scenario 'autorização' do
    visit reabrir_processos_path
    page.should have_content 'Você não tem permissão para acessar esse conteudo.'
  end

  scenario 'processos encerrados devem ser mostrados relativamente ao setor selecionado', js: true do
    login_as(create(:user, role: 'admin'), :scope => :user)

    setor1 = create :setor, nome: 'Setor 1'
    no_ano(2012) do 
      criar_processo_encerrado_em(setor1) 
      criar_processo_encerrado_em(create :setor)
    end
    visit reabrir_processos_path

    select 'Setor 1', from: 'Setor'

    within_fieldset 'Processos esperando reabrimento' do
      page.should have_content '00001/12'
      page.should have_link 'Reabrir'
      page.should_not have_content '00002/12'
    end
    
    click_link 'Reabrir'
    page.should have_content 'Processo 00001/12 foi reaberto'
    
    page.should_not have_content 'Processos esperando reabrimento'
  end
end