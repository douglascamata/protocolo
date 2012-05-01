#encoding: utf-8

require 'spec_helper'

feature 'criação de requerimento' do
  scenario 'criação de requerimento padrão' do
    FactoryGirl.create(:setor, nome: 'setor_1')
    FactoryGirl.create(:setor, nome: 'setor_2')
    FactoryGirl.create(:solicitante, nome: 'requerente_1')
    FactoryGirl.create(:solicitante, nome: 'interessado_1')
    FactoryGirl.create(:solicitacao, tipo: 'tipo_1')

    visit new_requerimento_path
    select 'setor_1', from: 'Local de Criação'
    fill_in 'Conteudo', with: 'Conteudo do Requerimento'
    select 'requerente_1', from: 'Requerente'
    select 'interessado_1', from: 'Interessado'
    select 'tipo_1', from: 'Tipo de Solicitação'
    select 'setor_2', from: 'Destino Inicial'
    click_button 'Salvar'

    page.should have_content 'setor_1'
    page.should have_content '00001/12'
    page.should have_content Date.today.strftime("%d/%m/%y")
    page.should have_content 'Conteudo do Requerimento'
    page.should have_content 'requerente_1'
    page.should have_content 'interessado_1'
    page.should have_content 'tipo_1'
    page.should have_content 'setor_2'
  end
end
