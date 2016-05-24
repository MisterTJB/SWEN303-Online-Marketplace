/**
 * Contains jQuery functions for managing user login
 */

/**
 * Set up the page appropriately with respect to current state (e.g. logged in, etc.)
 */
$(document).ready(function(){
    toggleLoginLogout();
});


/**
 * Executes a POST request against the login endpoint to validate the supplied credentials and calls
 * a relevant success/failure handler (c.f. loginSuccess() and loginFailure()).
 */
function login(){
    var email = $("#email").val();
    var password = $("#password").val();
    var credentials = {email: email, password: password}
    $.post("/login", credentials, function(data){

        if (data === true){
            loginSuccess(email);
        } else {
            loginFailure();
        }
    });
}

/**
 * Sets the visibility of the login menu or the logout button according to
 * whether the loggedInAs property is set in sessionStorage.
 */
function toggleLoginLogout(){
    if (window.sessionStorage.getItem("loggedInAs") != null){
        $("#logoutLink").show();
        $("#menuBarLogin").hide();
    } else {
        $("#logoutLink").hide();
        $("#menuBarLogin").show();
    }
}

/**
 * Handler for a successful login
 */
function loginSuccess(email){
    window.sessionStorage.setItem("loggedInAs", email);
    toggleLoginLogout();
    console.log("Successfully logged in");
}


/**
 * Handler for a failed login attempt
 */
function loginFailure(){
    console.log("Couldn't log in");
}

/**
 * Handler for logging out
 */
function logout(){
    window.sessionStorage.removeItem("loggedInAs");
    toggleLoginLogout();
}