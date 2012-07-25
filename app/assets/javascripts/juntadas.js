$(document).ready(function() {
  $('button#buscar').click(function() {
    var numero_protocolo = $('input#numero_protocolo').attr("value");
    $.get('/juntadas/buscar?numero_protocolo=' + numero_protocolo);
  });

  $('#processo').change(function() {
    var id = this.value;
    $.get('/juntadas/atualizar_processos?processo_id=' + id);
  });

});

