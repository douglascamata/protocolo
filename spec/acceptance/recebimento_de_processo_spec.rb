# encoding: utf-8

require 'spec_helper'

feature 'recebimento de processo' do
  scenario 'autorização' do
    visit receber_processos_path
    current_path.should_not == receber_processos_path
    page.should have_content 'Você não tem permissão para acessar esse conteudo.'
  end

  scenario 'padrão', js: true do
    setor1 = create :setor
    user_solicitante = create(:user_solicitante)
    user_solicitante.solicitante.setores << setor1

    [user_solicitante, create(:user_admin)].each do |user|
      login_as(user, :scope => :user)
      
      no_ano(2012) { @processo = criar_processo_enviado_para(setor1) }
      
      visit receber_processos_path
      select setor1.nome, from: 'Destino atual'
      
      within_fieldset 'Processos não recebidos' do
        page.should have_content @processo.numero_protocolo
        click_link 'Receber'
      end

      page.should have_content 'Processo ' + @processo.numero_protocolo + ' recebido com sucesso'
    end
  end
end
