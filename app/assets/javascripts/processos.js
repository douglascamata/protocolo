$(document).ready(function() {
  $('a.foo').hide().click();

  $('#recebimento_setor').change(function() {
    var id = this.value;
    $.get('/processos/aguardando_recebimento?setor_id=' + id);
  });
});
