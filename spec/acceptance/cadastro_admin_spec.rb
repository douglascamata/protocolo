# encoding: utf-8
require 'spec_helper'

feature "Cadastro usuario" do
  scenario 'autorização como admin' do
    visit new_user_path
    page.should have_content 'Você não tem permissão para acessar esse conteudo.'

    login_as(create(:user, role: 'admin'), :scope => :user)
    visit new_user_path
    page.should have_content 'Cadastrar Administrador'
  end

  scenario 'Cadastro de Administrador' do
    login_as(create(:user, role: 'admin'), :scope => :user)
    visit new_user_path
    fill_in 'Email', with: 'admin@email.com'
    fill_in 'Password', with: '123456'
    click_button 'Salvar'

    page.should have_content 'Administrador criado com sucesso!'
    page.should have_content 'Papel: Administrador'
    page.should have_content 'admin@email.com'
  end
end

