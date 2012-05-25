# encoding: utf-8
require 'spec_helper'

feature "encerrar processo" do
  scenario 'pesquisa por um processo e tentar encerrar o mesmo', javascript: true do
    setor1 = create :setor, nome: 'Setor 1'
    setor2 = create :setor, nome: 'Setor 2'
    processo = create :processo, setor_origem: setor1, destino_inicial: setor2
    receber_processo_em(processo, setor2)
    create :motivo, nome: "motivo 1"
    
    visit encerrar_processos_path

    fill_in 'Processo', with: '00001/12'
    click_button 'Buscar'

    within_fieldset 'Processo' do
      page.should have_content 'Numero protocolo: 00001/12'
      page.should have_content 'Setor 1'
      page.should have_content 'Setor 2'
    end

    within_fieldset 'Encerrar processo' do
      page.should have_content 'Data de encerramento: ' + Date.today.strftime("%d/%m/%y")
      page.should have_content 'Local de arquivamento: Setor 2'

      select 'motivo 1', from: 'Motivo'
      fill_in 'Observações', with: 'Obeservação qualquer'
      click_button 'Encerrar'
    end

    page.should have_content 'Processo encerrado.'
    page.should have_content 'Encerrado em: 01/01/12' #hr não foi testada pois se o teste demorar ela sera alterada, logo nao tem como saber exatamente a hr, mas tem teste para o metodo de geração da mesma
    page.should have_content 'Arquivado em: Setor 2' 
  end
end