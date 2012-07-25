$(document).ready(function() {

  $('#processo').change(function() {
    var id = this.value;
    $.get('/juntadas/atualizar_processos?processo_id=' + id);
  });

});

