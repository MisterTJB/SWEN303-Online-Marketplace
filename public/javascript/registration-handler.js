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

/**
 * Checks to ensure that the two password fields match
 */
function checkPassword(){
    var passwordA = $("#inputPassword");
    var passwordB = $("#inputPasswordVerify");
    console.log(passwordA);
    if (passwordA.val().length === passwordB.val().length) {
        if (passwordA.val() === passwordB.val()) {
            passwordA.css('background-color', 'green');
            passwordB.css('background-color', 'green');
        } else {
            passwordA.css('background-color', 'red');
            passwordB.css('background-color', 'red');
        }
    }
}