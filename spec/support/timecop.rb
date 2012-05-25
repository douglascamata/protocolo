def no_ano(ano)
  Timecop.freeze(ano, 1, 1, 1, 1, 1) { yield }
end

def no_ano_e_hr(ano,hr,min,segundo)
  Timecop.freeze(ano, 1, 1, hr, min, segundo){ yield }
end