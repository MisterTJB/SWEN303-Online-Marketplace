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

    $("#valuationButton").click(function(){
       var value = $("#valuationInput").val();
        var productID = window.location.pathname.split("/")[window.location.pathname.split("/").length - 1];
        $.post("/valuation/" + productID, {valuation: value, user: localStorage.getItem("loggedInAs")}, function(data){
            window.location.reload(true);
        });
    });

    if($("#voters > li:contains('%')".replace("%", localStorage.getItem('loggedInAs'))).length != 0 || $("#listedBy").text() === localStorage.getItem('loggedInAs')){
        $("#upButton").prop('disabled', true);
        $("#downButton").prop('disabled', true);
    }

    populateUserComplaintDropdown();

    toggleCartButton();
    
    toggleValuation();

});

function toggleCartButton(){
    if (productIsInCart()){

        $("#addToCart").hide();
        $("#removeFromCart").show();
    } else {
        $("#addToCart").show();
        $("#removeFromCart").hide();
    }
}

function toggleValuation(){
    
    $.get(window.location.pathname + "/valued-by/" + localStorage.getItem("loggedInAs"), function(data){
        console.log("User has valued: " + data.userHasValued);
        if (data.userHasValued === true){
            console.log("Removing valuation controls");
            $("#valuationControls").remove();
            $("#valuationText").append("(including you)");
        }
    });
}

function productIsInCart(){
    var productID = window.location.pathname.split("/")[window.location.pathname.split("/").length - 1];
    var cart = JSON.parse(localStorage.getItem("cart"));
    if (cart){
        return (cart.indexOf(productID) != -1);
    } else {
        return false;
    }
}

function addToCart(){
    var productID = window.location.pathname.split("/")[window.location.pathname.split("/").length - 1];
    var cart = JSON.parse(localStorage.getItem("cart"));

    if (cart && cart.indexOf(productID) === -1){
        cart.push(productID);
        localStorage.setItem("cart", JSON.stringify(cart));
    } else {
        localStorage.setItem("cart", JSON.stringify([productID]));
    }
    toggleCartButton();
}

function removeFromCart(){
    var productID = window.location.pathname.split("/")[window.location.pathname.split("/").length - 1];
    var cart = JSON.parse(localStorage.getItem("cart"));
    var index = cart.indexOf(productID);
    cart.splice(index, 1);
    localStorage.setItem("cart", JSON.stringify(cart));
    toggleCartButton();
}

function sendUserComplaint(){
    var productID = window.location.pathname.split("/")[window.location.pathname.split("/").length - 1];
    var username = getSelectedUser();
    console.log(username);
    var postData = {username : username, complainant : localStorage.getItem("loggedInAs"), complaint: $("#user-complaint-text").val(), productid: productID}
    $.post("/complaints/user", postData, function(data){

    });
    $("#user-complaint-text").val('');
}

function getSelectedUser(){
    return $( "#selectUser option:selected" ).text();
}

function populateUserComplaintDropdown(){
    $.get(window.location.pathname + "/raw", function(data){
        console.log(data);
        var users = new Set();
        for (voter in data.voters){
            users.add(data.voters[voter]);
        }
        for (valuer in data.valuersList){
            users.add(data.valuersList[valuer]);
        }
        users.add(data.listed_by);
        console.log(users);
        var userArray = Array.from(users).sort();

        var options = "";
        for (user in userArray){
            options = options + "<option>%USER%</option>".replace("%USER%", userArray[user]);
        }
        $("#selectUser").append(options);
    });
}

function sendProductComplaint(){
    var productID = window.location.pathname.split("/")[window.location.pathname.split("/").length - 1];
    var postData = {username: localStorage.getItem("loggedInAs"), complaint: $("#product-complaint-text").val()}
    $.post("/complaints/product/" + productID, postData, function(data){


    });
    $("#product-complaint-text").val('');
}