# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
 ActiveSupport::Inflector.inflections do |inflect|
   inflect.irregular 'setor', 'setores'
   inflect.irregular 'solicitacao', 'solicitacoes'

   inflect.irregular 'tipo_solicitacao', 'tipos_solicitacao'
   inflect.irregular 'TipoSolicitacao', 'TiposSolicitacao'
 end
#
# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.acronym 'RESTful'
# end
