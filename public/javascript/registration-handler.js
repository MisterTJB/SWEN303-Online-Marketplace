/**
 * Provides client-side functions for validating the registration form
 */


/**
 * Performs a check against the database to determine whether a username already exists
 */
function checkUsername(){
    $.get("users-endpoint?username=" + $("#inputUsername").val(), function(data){
        if (!data){
            $("#inputUsername").css('background-color', 'green');
        } else {
            $("#inputUsername").css('background-color', 'red');
        }
    });
}