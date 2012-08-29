#encoding: utf-8

require 'spec_helper'

feature 'Juntada de processo' do
  background do
    @processo_1 = create(:processo, numero_protocolo: '00001/12')
    @processo_2 = create(:processo, numero_protocolo: '00002/12')
    @processo_3 = create(:processo, numero_protocolo: '00003/12')   
  end

  scenario 'autorização como admin' do
    visit new_juntada_path
    current_path.should_not == new_juntada_path
    page.should have_content 'Você não tem permissão para acessar esse conteudo.'

    visit desapensar_juntadas_path
    current_path.should_not == desapensar_juntadas_path
    page.should have_content 'Você não tem permissão para acessar esse conteudo.'

    visit desanexar_juntadas_path
    current_path.should_not == desanexar_juntadas_path
    page.should have_content 'Você não tem permissão para acessar esse conteudo.'

    login_as(create(:user, role: 'admin'), :scope => :user)

    visit new_juntada_path
    current_path.should == new_juntada_path

    visit desapensar_juntadas_path
    current_path.should == desapensar_juntadas_path

    visit desanexar_juntadas_path
    current_path.should == desanexar_juntadas_path
  end

  scenario 'Realizar juntada de processos', js: true do
    login_as(create(:user, role: 'admin'), :scope => :user)

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

  scenario 'Desapensar Processo de Juntada', js: true do
    login_as(create(:user, role: 'admin'), :scope => :user)
    
    create(:juntada, tipo: "Apensar", processo_principal: @processo_1, processos: [@processo_2, @processo_3])

    visit desapensar_juntadas_path

    select "00001/12", on: "Processo"
    uncheck '00002/12'
    click_button 'Desapensar'

    page.should have_content 'Processos desapensado com sucesso'
    page.should_not have_content '00002/12'
  end

  scenario 'Desanexar Processo de Juntada', js: true do
    login_as(create(:user, role: 'admin'), :scope => :user)
    
    create(:juntada, tipo: "Anexar", processo_principal: @processo_1, processos: [@processo_2, @processo_3])

    visit desanexar_juntadas_path
    select "00001/12", on: "Processo"
    uncheck '00002/12'
    click_button 'Desanexar'

    page.should have_content 'Processos desanexado com sucesso'
    page.should_not have_content '00002/12'
  end

end

