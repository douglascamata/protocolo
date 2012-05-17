#encoding: utf-8
require 'spec_helper'

describe Despacho do
  context 'criação' do
    it {should_not have_valid(:conteudo).when(nil) }
  end
end
