#encoding: utf-8

require 'spec_helper'

feature 'enviar processos', javascript: true do
  background do
    @setor_1 = create :setor, nome: 'Setor_1'
    @setor_2 = create :setor, nome: 'Setor_2'
    @setor_3 = create :setor, nome: 'Setor_3'
  end

  scenario 'nova tramitação sem usuario destino' do

    create :processo, setor_origem: @setor_1, destino_inicial: @setor_3
    create :processo, setor_origem: @setor_2, destino_inicial: @setor_3

    visit new_tramitacao_path

    page.should_not have_content('00001/12')
    page.should_not have_content('00002/12')

    select 'Setor_1', from: 'Setor de origem'

    page.should have_content '00001/12'
    page.should_not have_content '00002/12'

    select 'Setor_2', from: 'Setor de destino'
    select '00001/12', from: 'Processo'

    click_button 'Enviar'

    page.should have_content 'Processos enviados.'
    page.should have_content 'Setor_1'
    page.should have_content 'Setor_2'
    page.should have_content '00001/12'
  end

  scenario 'enviar um processo que já foi enviado uma ou mais vezes' do
    processo = create :processo, setor_origem: @setor_1, destino_inicial: @setor_3
    processo.tramitacoes.create(setor_origem: @setor_1, setor_destino: @setor_2)

    visit new_tramitacao_path

    select 'Setor_1', from: 'Setor de origem'
    page.should_not have_content '00001/12'

    select 'Setor_2', from: 'Setor de origem'
    page.should have_content '00001/12'

    select 'Setor_3', from: 'Setor de destino'
    select '00001/12', from: 'Processo'

    click_button 'Enviar'

    page.should have_content 'Processos enviados.'
    page.should have_content 'Setor_2'
    page.should have_content 'Setor_3'
    page.should have_content '00001/12'
  end
end
