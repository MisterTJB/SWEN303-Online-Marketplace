/**
 * Provides client-side functions for validating the registration form
 */

var usernameValid = false;
var passwordValid = false;
var inviteValid = false;

/**
 * Performs a check against the database to determine whether a username already exists
 */
function checkUsername(){
    $.get("users-endpoint?username=" + $("#inputUsername").val(), function(data){
        if (!data){
            $("#inputUsername").css('background-color', 'green');
            usernameValid = true;
        } else {
            $("#inputUsername").css('background-color', 'red');
            usernameValid = false;
        }
        toggleRegister();
    });

}

/**
 * Checks to ensure that the two password fields match and colours the fields red (no match) or green (match)
 */
function checkPassword(){
    var passwordA = $("#inputPassword");
    var passwordB = $("#inputPasswordVerify");

    if (passwordA.val().length === passwordB.val().length){
        if (passwordA.val() === passwordB.val()) {
            passwordA.css('background-color', 'green');
            passwordB.css('background-color', 'green');
            passwordValid = true;
        } else {
            passwordA.css('background-color', 'red');
            passwordB.css('background-color', 'red');
            passwordValid = false;
        }
    } else {
        passwordA.css('background-color', 'white');
        passwordB.css('background-color', 'white');
        passwordValid = false;
    }

    toggleRegister();
}

/**
 * Checks to ensure that an invitation code is valid
 */
function checkInviteCode(){
    $("#codeHasBeenUsed").hide(300);
    $.get("invite-code-endpoint/" + $("#inviteCode").val(), function(data){
        if (data.validCode && !data.used){
            $("#inviteCode").css('background-color', 'green');
            inviteValid = true;
        } else {
            $("#inviteCode").css('background-color', 'red');
            if (data.used){
                $("#codeHasBeenUsed").show(400);
            }
            inviteValid = false;
        }
        toggleRegister();
    });


}

/**
 * Handles enabling/disabling of the register button according to whether a) the username is available and b) the
 * passwords match
 */
function toggleRegister(){
    $("#register-button").prop('disabled', !(usernameValid && passwordValid && inviteValid));

}

/**
 * Sets the loggedInAs local storage variable so that the user is logged in
 */
function setLocalStorage(){
    localStorage.setItem("loggedInAs", $("#inputUsername").val());
}