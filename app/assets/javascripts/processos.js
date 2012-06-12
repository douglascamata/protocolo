$(document).ready(function() {
  $('#recebimento_setor').change(function() {
    var id = this.value;
    $.get('/processos/aguardando_recebimento?setor_id=' + id);
  });

  $('button#buscar').click(function() {
    var numero_protocolo = $('input#numero_protocolo').attr("value");
    $.get('/processos/buscar?numero_protocolo=' + numero_protocolo);
  });

  $('#reabrir_no_setor').change(function() {
    var id = this.value;
    $.get('/processos/aguardando_reabrimento?setor_id=' + id);
  });

});
