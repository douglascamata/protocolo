# encoding: utf-8
require 'spec_helper'

feature "reabrir processo" do
  scenario 'autorização' do
    visit reabrir_processos_path
    page.should have_content 'Você não tem permissão para acessar esse conteudo.'
  end

  scenario 'processos encerrados devem ser mostrados relativamente ao setor selecionado', js: true do
    setor1 = create :setor
    user_solicitante = create(:user_solicitante)
    user_solicitante.solicitante.setores << setor1

    [user_solicitante, create(:user_admin)].each do |user|
      login_as(user, :scope => :user)

      no_ano(2012) do 
        @processo_1 = criar_processo_encerrado_em(setor1) 
        @processo_2 = criar_processo_encerrado_em(create :setor)
      end
      visit reabrir_processos_path

      select setor1.nome, from: 'Setor'

      within_fieldset 'Processos esperando reabrimento' do
        page.should have_content @processo_1.numero_protocolo
        page.should have_link 'Reabrir'
        page.should_not have_content @processo_2.numero_protocolo
      end
      
      click_link 'Reabrir'
      page.should have_content 'Processo ' + @processo_1.numero_protocolo + ' foi reaberto'
      
      page.should_not have_content 'Processos esperando reabrimento'

      logout :user
    end
  end
end