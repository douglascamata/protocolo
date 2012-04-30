FactoryGirl.define do
  factory :setor do
    sequence(:nome) {|n| "Nome#{n}" }
  end

  factory :solicitante do
    sequence(:nome) {|n| "Nome#{n}" }
  end

  factory :solicitacao do
    sequence(:tipo) {|n| "Tipo_#{n}" }
  end

  factory :requerimento do
    setor { [FactoryGirl.create(:setor)] }
    requerente { [FactoryGirl.create(:solicitante)] }
    interessado { [FactoryGirl.create(:solicitante)] }
    destino_inicial { [FactoryGirl.create(:setor)] }
    tipo_solicitacao { [FactoryGirl.create(:solicitacao)] }
    sequence(:numero_protocolo) {|n| "#{n}/12" }
    conteudo "MeuConteudo"
  end

end

