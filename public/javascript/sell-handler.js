/**
 * Created by Tim on 22/05/16.
 */

$(document).ready(function(){
    $("#cancelButton").attr("href", "/users/" + localStorage.getItem("loggedInAs"));
    $("#usernameField").attr("value", localStorage.getItem("loggedInAs"));
});