$(document).ready(function(){
  $(".alert-box").delay(5500).fadeOut(2000); 

  $("#wiki_public_false").click(function() {
        $(".js-notes").slideDown().removeClass('hide');
        if (document.getElementById("js-free-note")) {
          document.getElementById("btnSave").disabled = true; 
        }
        else
          document.getElementById("btnSave").disabled = false; 
      });

    $("#wiki_public_true").click(function() {
        $(".js-notes").slideUp().addClass('hide');
        document.getElementById("btnSave").disabled = false;
      });

    $('a.reveal-link').trigger('click');
    $('a.close-reveal-modal').trigger('click');


  $(window).load(updateTables);
  $(window).on("redraw",function(){switched=false;updateTables();}); // An event to listen for
  $(window).on("resize", updateTables);
});
