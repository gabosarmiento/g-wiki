// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .
//= require modernizr

$(function(){ $(document).foundation(); });

$(document).ready(function(){
  $(".alert-box").delay(1500).fadeOut(2000); 

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
    
});


