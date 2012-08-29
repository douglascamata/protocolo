#encoding: utf-8

require 'spec_helper'

feature 'gerenciar processo' do
  scenario 'autorização como admin' do
    visit new_processo_path
    current_path.should_not == new_processo_path
    page.should have_content 'Você não tem permissão para acessar esse conteudo.'

    processo = create :processo
    visit processo_path(processo)
    current_path.should_not == processo_path(processo)
    page.should have_content 'Você não tem permissão para acessar esse conteudo.'

    login_as(create(:user, role: 'admin'), :scope => :user)
    
    visit new_processo_path
    current_path.should == new_processo_path

    visit processo_path(processo)
    current_path.should == processo_path(processo)
  end

  scenario 'criação de processo' do
    login_as(create(:user, role: 'admin'), :scope => :user)

    create(:setor, nome: 'setor_1')
    create(:setor, nome: 'setor_2')
    create(:solicitante, nome: 'requerente_1')
    create(:solicitante, nome: 'interessado_1')
    create(:tipo_solicitacao, descricao: 'tipo_1')

    visit new_processo_path
    select 'setor_1', from: 'Local de Criação'
    fill_in 'Conteudo', with: 'Conteudo do processo'
    select 'requerente_1', from: 'Requerente'
    select 'interessado_1', from: 'Interessado'
    select 'tipo_1', from: 'Tipo de Solicitação'
    select 'setor_2', from: 'Destino Inicial'
    click_button 'Salvar'

    page.should have_content 'setor_1'
    page.should have_content '00001/12'
    page.should have_content Date.today.strftime("%d/%m/%y")
    page.should have_content 'Conteudo do processo'
    page.should have_content 'requerente_1'
    page.should have_content 'interessado_1'
    page.should have_content 'tipo_1'
    page.should have_content 'setor_2'
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

  scenario 'processo deve ter conhecimento de seus despachos' do
    login_as(create(:user, role: 'admin'), :scope => :user)
    
    processo = create(:processo)

    create :despacho, conteudo: 'Algum conteudo.', processo: processo

    visit processo_path(processo)
    page.should have_content '00001/12'
    page.should have_content 'Despachos'
    page.should have_content 'Algum conteudo'
  end
end
