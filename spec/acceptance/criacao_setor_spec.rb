#encoding: utf-8

require 'spec_helper'

feature 'criação de setor' do
  scenario 'criação de setor padrão' do

    visit new_setor_path
    fill_in 'Nome', with: 'Setor 1'
    click_button 'Save'

    page.should have_content 'Setor 1'
  end
end

