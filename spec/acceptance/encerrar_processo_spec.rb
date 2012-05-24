# encoding: utf-8
require 'spec_helper'

feature "encerrar processo" do
  scenario 'em processo recebido', javascript: true do
    setor1 = create :setor, nome: 'Setor 1'
    setor2 = create :setor, nome: 'Setor 2'
    processo = create :processo, setor_origem: setor1, destino_inicial: setor2
    no_ano(2012) { receber_processo_em(processo, setor2) }
    create :motivo, nome: "motivo 1"
    
    visit encerrar_processos_path

    fill_in 'Processo', with: '00001/12'
    click_button 'Buscar'

    within_fieldset 'Processo' do
      page.should have_content 'Numero protocolo: 00001/12'
      page.should have_content 'Setor 1'
      page.should have_content 'Setor 2'
    end

    within_fieldset 'Encerrar processo' do
      page.should have_content 'Data de encerramento: ' + Date.today.strftime("%d/%m/%y")
      page.should have_content 'Local de arquivamento: Setor 2'

      select 'motivo 1', from: 'Motivo'
      fill_in 'Observações', with: 'Obeservação qualquer'
      click_button 'Encerrar'
    end

    page.should have_content 'Processo Encerrado.'
  end
end