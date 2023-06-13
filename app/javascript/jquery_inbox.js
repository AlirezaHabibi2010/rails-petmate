$(document).ready(function() {
  $(".toggle-trigger").click(function() {
      $(this).parent().nextAll('.toggle-wrap').first().toggle('slow');
  });
});
