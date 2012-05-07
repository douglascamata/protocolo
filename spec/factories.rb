FactoryGirl.define do
  factory :setor do
    sequence(:nome) {|n| "Setor_#{n}" }
  end

  factory :solicitante do
    sequence(:nome) {|n| "Nome#{n}" }
  end

  factory :tipo_solicitacao do
    sequence(:descricao) {|n| "Tipo_#{n}" }
  end

  factory :requerimento do
    setor_origem { FactoryGirl.create(:setor) }
    requerente { FactoryGirl.create(:solicitante) }
    interessado { FactoryGirl.create(:solicitante) }
    destino_inicial { FactoryGirl.create(:setor) }
    tipo_solicitacao { FactoryGirl.create(:tipo_solicitacao) }
    sequence(:numero_protocolo) {|n| "#{n}/12" }
    conteudo "MeuConteudo"
  end

  factory :tramitacao do
  end

end
