#encoding: utf-8

require 'spec_helper'

feature 'gerenciar despacho' do
  scenario 'visualização de despacho' do
    tipo_solicitacao = create(:tipo_solicitacao, descricao: 'tipo_1')
    processo = create(:processo, tipo_solicitacao: tipo_solicitacao)

    despacho = create(:despacho, conteudo: 'Conteudo do despacho.', processo: processo)

    visit despacho_path(despacho)
    page.should have_content '00001/12'
    page.should have_content Date.today.strftime("%d/%m/%y")
    page.should have_content 'tipo_1'
    page.should have_content 'Conteudo do despacho.'
  end
end
