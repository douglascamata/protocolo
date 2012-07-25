Motivo.create! nome: "motivo_1"
Setor.create! nome: "setor_1"
Setor.create! nome: "setor_2"
Solicitante.create! nome: "solicitante_1"
Solicitante.create! nome: "solicitante_2"
TipoSolicitacao.create! descricao: "minha_descricao"
processo_1 = Processo.create! conteudo: "meu conteudo", requerente: Solicitante.first, interessado: Solicitante.all.second, setor_origem: Setor.first, destino_inicial: Setor.all.second, tipo_solicitacao: TipoSolicitacao.first
processo_2 = Processo.create! conteudo: "meu conteudo", requerente: Solicitante.first, interessado: Solicitante.all.second, setor_origem: Setor.first, destino_inicial: Setor.all.second, tipo_solicitacao: TipoSolicitacao.first
processo_3 = Processo.create! conteudo: "meu conteudo", requerente: Solicitante.first, interessado: Solicitante.all.second, setor_origem: Setor.first, destino_inicial: Setor.all.second, tipo_solicitacao: TipoSolicitacao.first
Juntada.create! processo_principal: processo_1, processos: [processo_2, processo_3], tipo: "Anexar"
Juntada.create! processo_principal: processo_2, processos: [processo_1, processo_3], tipo: "Apensar"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

