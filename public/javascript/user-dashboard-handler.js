/**
 * Provides functions for implementing client-side functionality within the user dashboard
 */

var codeGenerated = false;

function generateInviteCode(){

    var userid = sessionStorage.getItem("loggedInAs");
    $.post('/invite-code-endpoint', {userid: userid})
        .done( function(data) {
            $("#inviteCode").text(data.rows[0].code);
            codeGenerated = true;
        } )
        .fail( function(xhr, textStatus, errorThrown) {
            alert(errorThrown);
        });
}
