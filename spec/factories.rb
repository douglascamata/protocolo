FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user{n}@email.com" }
    password '123456'
  end

  factory :setor do
    sequence(:nome) {|n| "Setor_#{n}" }
  end

  factory :solicitante do
    sequence(:nome) {|n| "Nome#{n}" }
    sequence(:matricula) {|n| "0000#{n}" }
  end

  factory :tipo_solicitacao do
    sequence(:descricao) {|n| "Tipo_#{n}" }
  end

  factory :processo do
    setor_origem { create(:setor) }
    requerente { create(:solicitante) }
    interessado { create(:solicitante) }
    destino_inicial { create(:setor) }
    tipo_solicitacao { create(:tipo_solicitacao) }
    sequence(:numero_protocolo) {|n| "#{n}/12" }
    conteudo "MeuConteudo"
  end

  factory :tramitacao do
    association(:setor_destino, factory: :setor)
    association(:setor_origem, factory: :setor)
    processo
  end

  factory :despacho do
  end

  factory :motivo do
    nome "Motivo qualquer"
  end

  factory :juntada do
    processo_principal { create :processo }
    processos {create :processo}
    tipo "Anexar"
  end

end

