#encoding: utf-8

require 'spec_helper'

feature 'gerenciar despacho' do
  scenario 'autorização como admin' do
    visit new_despacho_path
    current_path.should_not == new_despacho_path
    page.should have_content 'Você não tem permissão para acessar esse conteudo.'

    login_as(create(:user, role: 'admin'), :scope => :user)
    visit new_despacho_path
    current_path.should == new_despacho_path
  end

  scenario 'criação de despacho' do
    login_as(create(:user, role: 'admin'), :scope => :user)
    
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
