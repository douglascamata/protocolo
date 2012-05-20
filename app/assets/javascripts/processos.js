$(document).ready(function() {
  $('#recebimento_setor').change(function() {
    var id = this.value;
    $.get('/processos/aguardando_recebimento?setor_id=' + id);
  });
});
