$(document).ready(function() {
  $('#tramitacao_setor_origem_id').change(function() {
    var id = this.value;
    $.get('/tramitacoes/atualizar_processos?setor_id=' + id);
  });
});
