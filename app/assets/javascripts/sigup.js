$(document).ready(
  $("#user_email").keyup(function() {
    var x = document.getElementById("user_email").value;
    var res = x.split("@")[1];
    if ( res === "gympass.com" ) {
      $("div#mortals" ).slideUp("normal", function() { $(this).hide(); } );
      $("div#home_address" ).slideUp("normal", function() { $(this).hide(); } );
      $( ".response" ).empty();
      $( ".response" ).append( "<h3 style='color: #D23333; font-weight: bold'>You are a GymPass employee.</h3>" );
      $('input[name="user[admin]"]').val("true");
    } else {
      $( ".response" ).empty();
      $("div#mortals" ).slideDown("normal", function() { $(this).show(); } );
      $("div#home_address" ).slideDown("normal", function() { $(this).show(); } );
      $('input[name="user[admin]"]').val("false");
    }
  })
);

$(document).ready(
  $("div#mortals").click(function() {
    if ( $('#user_type_user_0').is(':checked') ) {

      $("div#home_address" ).slideUp("normal", function() { $(this).hide(); } );

    } else {

      $("div#home_address" ).slideDown("normal", function() { $(this).show(); } );

    }
  })
);
