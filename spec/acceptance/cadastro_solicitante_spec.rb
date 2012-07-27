# encoding: utf-8
require 'spec_helper'

feature "Cadastrar Solicitante" do
  scenario 'Criação padrão' do
    create :setor, nome: 'Setor 1'
    create :setor, nome: 'Setor 2'
    create :setor, nome: 'Setor 3'

    visit new_solicitante_path
    fill_in 'Matricula', with: '0000001'
    fill_in 'Email', with: 'Meu_email@gmail.br'
    fill_in 'Nome', with: 'Nome_1'
    fill_in 'Endereço', with: 'Meu endereço'
    fill_in 'Telefone', with: '12345678'
    check 'Setor 1'
    check 'Setor 2'
    check 'Setor 3'
    click_button 'Salvar'

    page.should have_content 'Solicitante criado com sucesso!'
    page.should have_content '0000001'
    page.should have_content 'Meu_email@gmail.br'
    page.should have_content 'Nome_1'
    page.should have_content 'Meu endereço'
    page.should have_content '12345678'
    page.should have_content 'Setor 1'
    page.should have_content 'Setor 2'
    page.should have_content 'Setor 3'
  end
end
