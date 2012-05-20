def criar_processo_enviado_para(setor)
  processo = create :processo
  processo.enviar_para!(setor)
  processo
end
