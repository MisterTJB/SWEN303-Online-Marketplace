$(document).ready(function(){

    if (!localStorage.getItem("loggedInAs")){
        
        $("#content").remove();
        $("#newListings").remove();
    }

});