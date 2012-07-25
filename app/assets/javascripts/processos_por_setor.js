$(document).ready(function() {
  selecionar_e_procurar();
});

function selecionar_e_procurar () {
  $('.selecionar_e_procurar').change(function() {
    var id = this.value;
    $.ajax($(this).data('url'), {
      data: {setor_id: id}
    });
  });
}