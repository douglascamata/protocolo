#encoding: utf-8

require 'spec_helper'

feature 'consulta de processos' do
  scenario 'consultar feita apenas pelo numero de protocolo' do
    origem = create :setor, nome: 'setor_1'
    destino = create :setor, nome: 'setor_2'
    requerente = create :solicitante, nome: 'requerente_1'
    interessado = create :solicitante, nome: 'interessado_1'
    create :tipo_solicitacao, descricao: 'tipo_1'
    Timecop.freeze(2012, 7, 28, 11, 12, 11) {create :processo, requerente: requerente, interessado: interessado, 
    setor_origem: origem, destino_inicial: destino}
    
    visit processos_path

    fill_in 'q[numero_protocolo_cont]', with: '00001/12'
    select '27', on: 'q[created_at_gteq(3i)]'
    select 'Julho', on: 'q[created_at_gteq(3i)]'
    select '2012', on: 'q[created_at_gteq(1i)]'

    select '29', on: 'q[created_at_lt(3i)]'
    select 'Julho', on: 'q[created_at_lt(2i)]'
    select '2012', on: 'q[created_at_lt(1i)]'
    save_and_open_page

    click_button 'Pesquisar'


    page.should have_content '00001/12'
    page.should have_content 'setor_1'
    page.should have_content 'setor_2'
    page.should have_content 'requerente_1'
    page.should have_content 'interessado_1'
    page.should have_content 'tipo_1'
  end
end
