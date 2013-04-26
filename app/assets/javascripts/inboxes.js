$(document).ready(function(){
  // select the first message
  $('div.message').first().addClass('selected');

  $('html').keypress(function(e){
    e.preventDefault();
    // down key j
    if (e.which == 106 && $("div.selected").next().hasClass('message')){
      $('div.selected').removeClass('selected').next().addClass('selected');
    }
    // up key k
    if (e.which == 107 && $("div.selected").prev().hasClass('message')){
      $('div.selected').removeClass('selected').prev().addClass('selected');
    }
    // command dialog toggle a
    if (e.which == 97 && $("div.selected").length > 0) {
      $('div#command').modal("toggle");
    }
  });
});