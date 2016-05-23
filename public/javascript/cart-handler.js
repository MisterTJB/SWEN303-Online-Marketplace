$(document).ready(function(){
    
    var cart = JSON.parse(localStorage.getItem('cart'));
    if (!cart || cart.length === 0){
        $("#cartDiv").empty();
        $("#cartDiv").append("<h2>Your cart is empty</h2>");

    } else {
        var total = 0.0;
        for (product in cart){
            $.get("/product/" + cart[product] + "/raw", function(data){

                total = total + parseFloat(data.price);
                
                var productRow = '<tr id="' +cart[product]+ '">'+
                                   '<td class="col-sm-8 col-md-6">'+
                                        // '<div class="media">' +
                                        // '<a class="thumbnail pull-left" href="#">' +
                                        // '<img class="media-object"  src="http://placehold.it/72x72" style="width: 72px; height: 72px;"> </a>'+
                                        // '<div class="media-body">' +
                                        '<h4 class="media-heading"><a href="/product/' + cart[product] + '">' + data.title + '</a></h4>' +
                                        // '</div>' +
                                        // '</div>' +
                                        '<td class="col-sm-1 col-md-1 text-center"><strong>' + data.price + '</strong></td>' +
                                        '<td class="col-sm-1 col-md-1">' +
                    '<button type="button" class="btn btn-danger remove" onclick=removeFromCart('+ cart[product] + ')>' +
                     '<span class="glyphicon glyphicon-remove"></span>' +
                    '</button></td>' +
                    '</tr>';
                
                $("#cartDiv > table > tbody").prepend(productRow);
                $("#totalCost").text("$" + total);
            });
        }

    }
});

function removeFromCart(productID){
    var cart = JSON.parse(localStorage.getItem("cart"));
    var index = cart.indexOf(productID);
    cart.splice(index, 1);
    localStorage.setItem("cart", JSON.stringify(cart));
    $("#" + productID).remove();

    if (!cart || cart.length === 0){
        $("#cartDiv").empty();
        $("#cartDiv").append("<h2>Your cart is empty</h2>");

    }
}

function paid(){
    localStorage.setItem("cart", JSON.stringify([]));
    window.location.replace("/users/" + localStorage.getItem("loggedInAs"));
}