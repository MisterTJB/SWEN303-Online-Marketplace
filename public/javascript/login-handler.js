/**
 * Contains jQuery functions for managing user login
 */


/**
 * Executes a POST request against the login endpoint to validate the supplied credentials and calls
 * a relevant success/failure handler (c.f. loginSuccess() and loginFailure()).
 */
function login(){

    var credentials = {email: $("#email").val(), password: $("#password").val()}
    $.post("login", credentials, function(data){

        if (data === true){
            loginSuccess();
        } else {
            loginFailure();
        }
    });
}

/**
 * Handler for a successful login
 */
function loginSuccess(){
    console.log("Successfully logged in");
}


/**
 * Handler for a failed login attempt
 */
function loginFailure(){
    console.log("Couldn't log in");
}