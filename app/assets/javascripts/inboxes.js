$(document).ready(function(){
  // select the first message
  $('div.message').first().addClass('selected');

  $('html').keypress(function(e){
    console.log(e);
    e.preventDefault();
    if (e.which == 106 && $("div.selected").next().hasClass('message')){
      $('div.selected').removeClass('selected').next().addClass('selected');
    }
    if (e.which == 107 && $("div.selected").prev().hasClass('message')){
      $('div.selected').removeClass('selected').prev().addClass('selected');
    }
  });
});