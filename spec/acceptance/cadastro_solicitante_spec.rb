# encoding: utf-8
require 'spec_helper'

feature "Cadastrar Solicitante" do

  scenario 'autorização como admin' do
    visit new_solicitante_path
    page.should have_content 'Você não tem permissão para acessar esse conteudo.'

    login_as(create(:user, role: 'admin'), :scope => :user)
    visit new_solicitante_path
    page.should have_content 'Cadastrar Solicitante'
  end

  scenario 'Criação padrão' do
    login_as(create(:user, role: 'admin'), :scope => :user)
    
    create :setor, nome: 'Setor 1'
    create :setor, nome: 'Setor 2'
    create :setor, nome: 'Setor 3'

    visit new_solicitante_path
    fill_in 'Email', with: 'solicitante@email.com'
    fill_in 'Password', with: '123456'
    
    fill_in 'Matricula', with: '0000001'
    fill_in 'Nome', with: 'Nome_1'
    fill_in 'Endereço', with: 'Meu endereço'
    fill_in 'Telefone', with: '12345678'
    check 'Setor 1'
    check 'Setor 2'
    check 'Setor 3'
    click_button 'Salvar'

    page.should have_content 'Solicitante criado com sucesso!'
    page.should have_content 'Papel: Solicitante'
    page.should have_content 'solicitante@email.com'

    page.should have_content '0000001'
    page.should have_content 'Nome_1'
    page.should have_content 'Meu endereço'
    page.should have_content '12345678'
    page.should have_content 'Setor 1'
    page.should have_content 'Setor 2'
    page.should have_content 'Setor 3'
  end
end
