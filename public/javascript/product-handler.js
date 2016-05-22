/**
 * Created by Tim on 22/05/16.
 */


$(document).ready(function(){
    $("#upButton").click(function(){
        console.log("Voting up to: " + window.location.pathname);
        var postData = {voteUp: true, user: localStorage.getItem("loggedInAs")};
        $.post(window.location.pathname, postData,  function(data){
            window.location.reload(true);
        });
    });

    $("#downButton").click(function(){
        console.log("Voting down to: " + window.location.pathname);
        var postData = {user: localStorage.getItem("loggedInAs")};
        console.log(postData);
        $.post(window.location.pathname, postData,  function(data){
            window.location.reload(true);
        });
    });

    if($("#voters > li:contains('%')".replace("%", localStorage.getItem('loggedInAs'))).length != 0 || $("#listedBy").text() === localStorage.getItem('loggedInAs')){
        $("#upButton").prop('disabled', true);
        $("#downButton").prop('disabled', true);
    }

});
