#encoding: utf-8

require 'spec_helper'

feature 'enviar processos', js: true do
  background do
    @setor_1 = create :setor, nome: 'Setor_1'
    @setor_2 = create :setor, nome: 'Setor_2'
    @setor_3 = create :setor, nome: 'Setor_3'
  end

  scenario 'autorização' do
    visit new_tramitacao_path
    current_path.should_not == new_tramitacao_path
    page.should have_content 'Você não tem permissão para acessar esse conteudo.'
    
  
  end

  scenario 'nova tramitação sem usuario destino' do
    login_as(create(:user, role: 'admin'), :scope => :user)

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
    login_as(create(:user, role: 'admin'), :scope => :user)
    
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

  scenario 'processo deve ter conhecimento de toda a sua tramitação desde que foi criado' do
    login_as(create(:user, role: 'admin'), :scope => :user)

    setor_1 = create(:setor, nome: 'setor_1')
    setor_2 = create(:setor, nome: 'setor_2')
    setor_3 = create(:setor, nome: 'setor_3')
    setor_4 = create(:setor, nome: 'setor_4')
    processo = create(:processo, setor_origem: setor_1, destino_inicial: setor_4)

    create :tramitacao, setor_origem: setor_1, setor_destino: setor_2, processo: processo
    create :tramitacao, setor_origem: setor_2, setor_destino: setor_3, processo: processo
    create :tramitacao, setor_origem: setor_3, setor_destino: setor_4, processo: processo

    visit processo_path(processo)
    page.should have_content '00001/12'
    page.should have_content 'Tramitações'
    page.should have_content 'setor_1'
    page.should have_content 'setor_2'
    page.should have_content 'setor_3'
    page.should have_content 'setor_4'
  end
end
