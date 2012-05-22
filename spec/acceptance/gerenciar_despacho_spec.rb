#encoding: utf-8

require 'spec_helper'

feature 'gerenciar despacho' do
  scenario 'criação de despacho' do
    tipo_solicitacao = create(:tipo_solicitacao, descricao: 'tipo_1')
    processo = create(:processo, tipo_solicitacao: tipo_solicitacao)
    
    visit new_despacho_path
    fill_in 'Conteudo', with: 'Conteudo do despacho'
    select '00001/12', from: 'Processo'
    click_button 'Enviar'

    page.should have_content 'Despacho adicionado'
    page.should have_content '00001/12'
    page.should have_content Date.today.strftime("%d/%m/%y")
    page.should have_content 'tipo_1'
    page.should have_content 'Conteudo do despacho'
  end
end
