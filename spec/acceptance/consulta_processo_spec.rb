#encoding: utf-8

require 'spec_helper'

feature 'consulta de processos' do
  scenario 'consulta feita apenas pelo numero de protocolo' do
    origem = create :setor, nome: 'setor_1'
    requerente = create :solicitante, nome: 'requerente_1'
    interessado = create :solicitante, nome: 'interessado_1'
    tipo = create :tipo_solicitacao, descricao: 'tipo_1'
    2.times{ create :processo, requerente: requerente, interessado: interessado, setor_origem: origem, tipo_solicitacao: tipo }

    visit consultar_processos_path

    fill_in 'Numero protocolo', with: '00001/12'
    
    click_button 'Pesquisar'

    within_fieldset 'Resultados da busca' do
      page.should have_content '00001/12'
      page.should have_content 'setor_1'
      page.should have_content 'requerente_1'
      page.should have_content 'interessado_1'
      page.should have_content 'tipo_1'
      page.should have_content 'criado'
      page.should_not have_content '00002/12'
    end
  end

  scenario 'consulta feita apenas pelo intervalo de data de criação (inicio == intervalo fechado, final == intervalo aberto)' do
    Timecop.freeze(2012, 7, 28, 11, 12, 11) {4.times{create :processo}}
    Timecop.freeze(2012, 7, 27, 11, 12, 11) {2.times{create :processo}}
    Timecop.freeze(2012, 7, 29, 11, 12, 11) {2.times{create :processo}}

    visit consultar_processos_path
    fill_in 'data inicial', with: '28/07/2012'
    fill_in 'data final', with: '29/07/2012'

    click_button 'Pesquisar'

    within_fieldset 'Resultados da busca' do
      page.should have_content '00001/12'
      page.should have_content '00002/12'
      page.should have_content '00003/12'
      page.should have_content '00004/12'
      page.should_not have_content '00005/12'
      page.should_not have_content '00006/12'
      page.should_not have_content '00007/12'
      page.should_not have_content '00008/12'
    end
  end

  scenario 'consultar processos por estado' do
    processo_1 = create :processo
    processo_2 = create :processo
    setor = create :setor, nome: 'Setor destino'
    receber_processo_em(processo_1, setor)
    
    visit consultar_processos_path
    

    select 'recebido', from: 'q_estado_eq'

    click_button 'Pesquisar'

    within_fieldset 'Resultados da busca' do
      page.should have_content '00001/12'
      page.should have_content 'Setor destino'
      page.should_not have_content '00002/12'
    end
  end

  scenario 'consultar processos apenas por requerente' do
    requerente = create :solicitante, nome: 'Linus'
    requerente_2 = create :solicitante, nome: 'Goku'
    4.times{create :processo, requerente: requerente}
    create :processo, requerente: requerente_2

    visit consultar_processos_path
    
    fill_in 'Requerente', with: 'Linus'  
    click_button 'Pesquisar'

    within_fieldset 'Resultados da busca' do
      page.should have_content '00001/12'
      page.should have_content '00002/12'
      page.should have_content '00003/12'
      page.should have_content '00004/12'
      page.should have_content 'Linus'
      page.should_not have_content '00005/12'
      page.should_not have_content 'Goku'
    end
  end

  scenario 'consultar processos apenas por interessado' do
    interessado_1 = create :solicitante, nome: 'Matz'
    interessado_2 = create :solicitante, nome: 'Vegeta'
    4.times{create :processo, interessado: interessado_1}
    create :processo, interessado: interessado_2

    visit consultar_processos_path
    
    fill_in 'Interessado', with: 'Matz'
    
    click_button 'Pesquisar'

    within_fieldset 'Resultados da busca' do
      page.should have_content '00001/12'
      page.should have_content '00002/12'
      page.should have_content '00003/12'
      page.should have_content '00004/12'
      page.should have_content 'Matz'
      page.should_not have_content '00005/12'
      page.should_not have_content 'Vegeta'
    end
  end

  scenario 'consultar processos apenas por tipo de solicitação' do
    tipo = create :tipo_solicitacao, descricao: 'Complicado'
    tipo_2 = create :tipo_solicitacao, descricao: 'Simples'
    4.times{create :processo, tipo_solicitacao: tipo}
    create :processo, tipo_solicitacao: tipo_2

    visit consultar_processos_path
    
    select 'Complicado', from: 'q_tipo_solicitacao_id_eq'
    
    click_button 'Pesquisar'

    within_fieldset 'Resultados da busca' do
      page.should have_content '00001/12'
      page.should have_content '00002/12'
      page.should have_content '00003/12'
      page.should have_content '00004/12'
      page.should have_content 'Complicado'
      page.should_not have_content '00005/12'
      page.should_not have_content 'Simples'
    end
  end

  scenario 'consultar processos por setor de Origem' do
    origem_1 = create :setor, nome: 'setor_1'
    origem_2 = create :setor, nome: 'setor_2'
    2.times{create :processo, setor_origem: origem_1}
    create :processo, setor_origem: origem_2

    visit consultar_processos_path
  
    select 'setor_1', from: 'q_setor_origem_id_eq'
  
    click_button 'Pesquisar'

    within_fieldset 'Resultados da busca' do
      page.should have_content '00001/12'
      page.should have_content '00002/12'
      page.should have_content 'setor_1'
      page.should_not have_content '00003/12'
      page.should_not have_content 'setor_2'
    end
  end

  scenario 'consultar processos por setor de Destino (Destino inicial)' do
    destino_1 = create :setor, nome: 'setor_destino_1'
    destino_2 = create :setor, nome: 'setor_destino_2'
    2.times{create :processo, destino_inicial: destino_1}
    create :processo, destino_inicial: destino_2

    visit consultar_processos_path
    
    select 'setor_destino_1', from: 'q_destino_inicial_id_eq'
    
    click_button 'Pesquisar'

    within_fieldset 'Resultados da busca' do
      page.should have_content '00001/12'
      page.should have_content '00002/12'
      page.should_not have_content '00003/12'
    end
  end

  scenario 'a consulta deve fornecer um link para o processo' do
    login_as(create(:user, role: 'admin'), :scope => :user)  
    processo = create :processo
    
    visit consultar_processos_path
    fill_in 'Numero protocolo', with: '00001/12'
    
    within_fieldset 'Resultados da busca' do
      page.should have_content '00001/12'
    end
    
    click_link '00001/12'
    current_path.should == processo_path(processo)
  end

end

