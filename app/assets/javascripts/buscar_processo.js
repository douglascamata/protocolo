$(document).ready(function() {
  
  $('button#buscar').click(function() {
    var numero_protocolo = $('input#numero_protocolo').attr("value");
    $.ajax($(this).data('url'), {
      data: {numero_protocolo: numero_protocolo}
    });
  });

});
