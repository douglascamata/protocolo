# encoding: utf-8
require 'spec_helper'

feature "Cadastro Setor" do
  scenario 'autorização como admin' do
    visit new_setor_path
    page.should have_content 'Você não tem permissão para acessar esse conteudo.'

    logar create(:user, role: 'admin')
    visit new_setor_path
    page.should have_content 'Cadastrar Setor'
  end

  scenario 'Criação padrão' do
    logar create(:user, role: 'admin')
    visit new_setor_path
    fill_in 'Nome', with: 'Setor_1'
    click_button 'Salvar'

    page.should have_content 'Setor criado com sucesso!'
    page.should have_content 'Setor_1'
  end
end

