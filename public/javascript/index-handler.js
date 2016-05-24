$(document).ready(function(){

    if (!localStorage.getItem("loggedInAs")){
        
        $(".page-header").nextAll().remove();
        $("#advancedSearch").remove();
        $("#newListings").remove();
        $("#administrate").remove();
        $(".bs-docs-section").append("<h1>You need to log in...</h1>");
    }

});