#encoding: utf-8
require 'spec_helper'

#foi assumido q processos = requerimentos
feature 'enviar requerimentos' do
  scenario 'nova tramitação sem usuario destino com apenas 1 processo' do
    2.times{FactoryGirl.create :requerimento}
    
    visit new_tramitacao_path

    select 'Setor_1', from: 'Setor de origem'
    page.should have_content '00001/12'
    page.should_not have_content '00002/12'

    select 'Setor_2', from: 'Setor de destino'
    check '00001/12'

    click_button 'Enviar'

    page.should have_content 'Processos enviados.'
  end
end