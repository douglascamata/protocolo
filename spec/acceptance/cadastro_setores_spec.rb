# encoding: utf-8
require 'spec_helper'

feature "Cadastro Setor" do
  scenario 'Criação padrão' do
    visit new_setor_path
    fill_in 'Nome', with: 'Setor_1'
    click_button 'Salvar'

    page.should have_content 'Setor criado com sucesso!'
    page.should have_content 'Setor_1'
  end
end

