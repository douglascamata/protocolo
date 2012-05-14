#encoding: utf-8
require 'spec_helper'
#foi assumido q processos = requerimentos
feature 'enviar requerimentos', javascript: true do
  scenario 'nova tramitação sem usuario destino' do
    setor_1 = FactoryGirl.create :setor, nome: 'Setor_1'
    setor_2 = FactoryGirl.create :setor, nome: 'Setor_2'
    setor_3 = FactoryGirl.create :setor, nome: 'Setor_3'

    FactoryGirl.create :requerimento, setor_origem: setor_1, destino_inicial: setor_3
    FactoryGirl.create :requerimento, setor_origem: setor_2, destino_inicial: setor_3
    
    visit new_tramitacao_path

    page.should_not have_content('00001/12')
    page.should_not have_content('00002/12')

    select 'Setor_1', from: 'Setor de origem'
    
    page.should have_content '00001/12'
    page.should_not have_content '00002/12'

    select 'Setor_2', from: 'Setor de destino'
    select '00001/12', from: 'Requerimento'

    click_button 'Enviar'

    page.should have_content 'Processos enviados.'
    page.should have_content 'Setor_1'
    page.should have_content 'Setor_2'
    page.should have_content '00001/12'
  end
end

