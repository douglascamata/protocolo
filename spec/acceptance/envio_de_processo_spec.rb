#encoding: utf-8
require 'spec_helper'
#foi assumido q processos = requerimentos
feature 'enviar requerimentos', javascript: true do
  scenario 'nova tramitação sem usuario destino com apenas 1 processo' do
    setor_1 = FactoryGirl.create :setor, nome: 'Setor_1'
    setor_2 = FactoryGirl.create :setor, nome: 'Setor_2'
    
    FactoryGirl.create :requerimento, setor_origem: setor_1
    FactoryGirl.create :requerimento, setor_origem: setor_2
    
    visit new_tramitacao_path

    select 'Setor_1', from: 'Setor de origem'
    
    find_field('00001/12').visible?.should be_true 
    find_field('00002/12').visible?.should be_false 

    select 'Setor_2', from: 'Setor de destino'
    check '00001/12'

    click_button 'Enviar'

    page.should have_content 'Processos enviados.'
  end
end

