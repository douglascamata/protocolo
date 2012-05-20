def no_ano(ano)
  Timecop.freeze(ano, 1, 1, 1, 1, 1) { yield }
end
