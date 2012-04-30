#encoding: utf-8

require 'spec_helper'

feature 'criação de solicitante' do
  scenario 'criação de solicitante padrão' do

    visit new_solicitante_path
    fill_in 'Nome', with: 'Bart Simpson'
    click_button 'Save'

    page.should have_content 'Bart Simpson'
  end
end

