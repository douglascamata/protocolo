//main
$(function() {
  $('.check_boxes').hide();
  show_check_boxes();
});

function show_check_boxes () {
  $('#tramitacao_setor_origem_id').change(function() {
    $('.check_boxes').hide();
    $('.from_setor_' + $(this).attr("value")).show();
  })
};
