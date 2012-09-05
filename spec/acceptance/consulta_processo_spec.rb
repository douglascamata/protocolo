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
    save_and_open_page

    fill_in 'q[numero_protocolo_cont]', with: '00001/12'
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
    within_fieldset 'Data inicial' do
      select '28', on: 'q_created_at_gteq_3i'
      select 'Julho', on: 'q_created_at_gteq_2i'
      select '2012', on: 'q_created_at_gteq_1i'
    end
    within_fieldset 'Data final' do
      select '29', on: 'q_created_at_lt_3i'
      select 'Julho', on: 'q_created_at_lt_2i'
      select '2012', on: 'q_created_at_lt_1i'
    end
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
    
    within_fieldset 'Estado' do
      select 'recebido', from: 'q[estado_eq]'
    end
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
    within_fieldset 'Requerente' do
      fill_in 'q[requerente_nome_cont]', with: 'Linus'
    end
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
    within_fieldset 'Interessado' do
      fill_in 'q[interessado_nome_cont]', with: 'Matz'
    end
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
    within_fieldset 'Tipo de solicitação' do
      select 'Complicado', from: 'q[tipo_solicitacao_id_eq]'
    end
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
    within_fieldset 'Setor de Origem' do
      select 'setor_1', from: 'q[setor_origem_id_eq]'
    end
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
    within_fieldset 'Setor de Destino' do
      select 'setor_destino_1', from: 'q[destino_inicial_id_eq]'
    end
    click_button 'Pesquisar'

    within_fieldset 'Resultados da busca' do
      page.should have_content '00001/12'
      page.should have_content '00002/12'
      page.should_not have_content '00003/12'
    end
  end

end

