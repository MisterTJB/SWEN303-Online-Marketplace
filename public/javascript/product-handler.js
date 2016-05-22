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

    toggleCartButton();

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
    } else if (cart.indexOf(productID) === -1) {
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