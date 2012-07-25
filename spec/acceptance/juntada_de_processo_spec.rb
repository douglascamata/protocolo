#encoding: utf-8

require 'spec_helper'

feature 'Juntada de processo' do
  scenario 'Realizar juntada de processos', javascript: true do
    processo_1 = create(:processo, numero_protocolo: '00001/12')
    processo_2 = create(:processo, numero_protocolo: '00002/12')
    processo_3 = create(:processo, numero_protocolo: '00003/12')

    visit new_juntada_path
    fill_in 'processo_principal', with: '00001/12'
    click_button 'Buscar'
    select 'Anexar', from: 'Tipo'
    check '00002/12'
    check '00003/12'
    click_button 'Salvar'


    page.should have_content "Juntada realizada com sucesso!"
    page.should have_content 'Anexar'
    page.should have_content '00001/12'
    page.should have_content '00002/12'
    page.should have_content '00003/12'
  end
end

