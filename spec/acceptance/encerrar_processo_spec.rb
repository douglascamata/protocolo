# encoding: utf-8
require 'spec_helper'

feature "encerrar processo" do

  scenario 'autorização' do
    visit encerrar_processos_path
    current_path.should_not == encerrar_processos_path
    page.should have_content 'Você não tem permissão para acessar esse conteudo.'

    [create(:user_solicitante), create(:user_admin)].each do |user|
      login_as(user, :scope => :user)
      
      visit encerrar_processos_path
      current_path.should == encerrar_processos_path
      
      logout :user
    end
  end

  scenario 'pesquisa por um processo e tentar encerrar o mesmo', js: true do
    setor2 = create :setor
    user_solicitante = create(:user_solicitante)
    user_solicitante.solicitante.setores << setor2

    [user_solicitante, create(:user_admin)].each do |user|
      login_as(user, :scope => :user)

      setor1 = create :setor
      Timecop.freeze(2012, 5, 19, 8, 10, 11) { @processo = create :processo, setor_origem: setor1, destino_inicial: setor2 }
      receber_processo_em(@processo, setor2)
      create :motivo, nome: "motivo 1"
      
      visit encerrar_processos_path

      fill_in 'Processo', with: @processo.numero_protocolo
      click_button 'Buscar'

      within_fieldset 'Processo' do
        page.should have_content 'Numero protocolo: ' + @processo.numero_protocolo
        page.should have_content setor1.nome
        page.should have_content setor2.nome
        page.should_not have_content 'Arquivado em: Setor'
      end

      within_fieldset 'Encerrar processo' do
        page.should have_content 'Data de encerramento: ' + Date.today.strftime("%d/%m/%y")
        page.should have_content 'Local de arquivamento: ' + setor2.nome

        select 'motivo 1', from: 'Motivo'
        fill_in 'Observações', with: 'Obeservação qualquer'
        Timecop.freeze(2012, 5, 20, 10, 0, 11) { click_button 'Encerrar' }
      end

      page.should have_content 'Processo encerrado.'
      page.should have_content 'Encerrado em: 20/05/12'
      page.should have_content 'Arquivado em: ' + setor2.nome

      logout :user
    end  
  end
end