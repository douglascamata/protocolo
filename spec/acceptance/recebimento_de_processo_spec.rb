# encoding: utf-8

require 'spec_helper'

feature 'recebimento de processo' do
  scenario 'padrão', js: true do
    setor1 = create :setor, nome: 'Setor 1'
    create :setor, nome: 'Setor 2'
    no_ano(2012) { criar_processo_enviado_para(setor1) }
    visit receber_processos_path
    select 'Setor 1', from: 'Destino atual'
    within_fieldset 'Processos não recebidos' do
      page.should have_content '0001/12'
      click_link 'Receber'
    end
    page.should have_content 'Processo 00001/12 recebido com sucesso'
  end
end
