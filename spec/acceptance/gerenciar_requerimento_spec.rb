#encoding: utf-8

require 'spec_helper'

feature 'gerenciar requerimento' do
  scenario 'criação de requerimento' do
    FactoryGirl.create(:setor, nome: 'setor_1')
    FactoryGirl.create(:setor, nome: 'setor_2')
    FactoryGirl.create(:solicitante, nome: 'requerente_1')
    FactoryGirl.create(:solicitante, nome: 'interessado_1')
    FactoryGirl.create(:tipo_solicitacao, descricao: 'tipo_1')

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

  scenario 'requerimento deve ter conhecimento de toda a sua tramitação desde que foi criado' do
    setor_1 = FactoryGirl.create(:setor, nome: 'setor_1')
    setor_2 = FactoryGirl.create(:setor, nome: 'setor_2')
    setor_3 = FactoryGirl.create(:setor, nome: 'setor_3')
    setor_4 = FactoryGirl.create(:setor, nome: 'setor_4')
    requerimento = FactoryGirl.create(:requerimento, setor_origem: setor_1, destino_inicial: setor_4)

    FactoryGirl.create :tramitacao, setor_origem: setor_1, setor_destino: setor_2, requerimento: requerimento
    FactoryGirl.create :tramitacao, setor_origem: setor_2, setor_destino: setor_3, requerimento: requerimento
    FactoryGirl.create :tramitacao, setor_origem: setor_3, setor_destino: setor_4, requerimento: requerimento

    visit requerimento_path(requerimento)
    page.should have_content '00001/12'    
    page.should have_content 'Tramitações'
    page.should have_content 'setor_1'
    page.should have_content 'setor_2'
    page.should have_content 'setor_3'
    page.should have_content 'setor_4'
  end

  scenario 'requerimento deve ter conhecimento de seus despachos' do
    requerimento = FactoryGirl.create(:requerimento)

    FactoryGirl.create :despacho, conteudo: 'Algum conteudo.', requerimento: requerimento

    visit requerimento_path(requerimento)
    page.should have_content '00001/12'
    page.should have_content 'Despachos'
    page.should have_content 'Algum conteudo'
  end
end
