def criar_processo_enviado_para(setor)
  processo = create :processo
  processo.enviar_para!(setor)
  processo
end

def receber_processo_em(processo, setor)
	processo.enviar_para!(setor)
  processo.receber!
end
