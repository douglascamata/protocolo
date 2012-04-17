# encoding: utf-8

require 'spec_helper'

feature 'aceitação' do
  scenario 'funciona' do
    visit root_path
    page.should have_content 'Página principal'
  end
end

