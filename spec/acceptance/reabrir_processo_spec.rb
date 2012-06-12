# encoding: utf-8
require 'spec_helper'

feature "reabrir processo", javascript: true do
  scenario 'processos encerrados devem ser mostrados relativamente ao setor selecionado' do
    setor1 = create :setor, nome: 'Setor 1'
    no_ano(2012) { 2.times{ criar_processo_encerrado_em(setor1) } }
    visit reabrir_processos_path

    select 'Setor 1', from: 'Setor'
    page.should have_content '00001/12'
    page.should have_content '00002/12'
  end
end