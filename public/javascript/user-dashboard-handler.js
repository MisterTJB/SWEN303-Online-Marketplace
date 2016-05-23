/**
 * Provides functions for implementing client-side functionality within the user dashboard
 */

var codeGenerated = false;

$(document).ready(function(){
    if(localStorage.getItem("referrer") === "pay"){
        $("#pastOrders").click();
        localStorage.removeItem("referrer");
    }
});

function loadPastOrders(){
    $("#dashboardData").empty();
    $.get("/transactions/" + localStorage.getItem("loggedInAs"), function(data){
       for (order in data){
           $("#dashboardData").append("<li class='list-group-item' id='" + data[order].tid + "'><h2>Order #" + data[order].tid + "</h2></li>");
           for (product in data[order].products){
               $("#" + data[order].tid).append("<a href='/product/" + data[order].products[product] + "'>" + "Stuff</a>");
           }
           $("#" + data[order].tid).append("<hr>");
       }
    });
}

function generateInviteCode(){

    var userid = sessionStorage.getItem("loggedInAs");
    $.post('/invite-code-endpoint', {userid: userid})
        .done( function(data) {
            $("#inviteCode").text(data.rows[0].code);
            codeGenerated = true;
        } )
        .fail( function(xhr, textStatus, errorThrown) {
            alert(errorThrown);
        });
}

function mean(list){
    if (list.length > 0){
        var sum = list.reduce(function(a, b){return a+b;});
        return sum/list.length;
    } else {
        return 0;
    }
}

function listItemsForSale(){
    $("#dashboardData").empty();
    $.get("/users-endpoint/" + localStorage.getItem("loggedInAs") + "/forsale", function(data){

        for (element in data){
            var title = data[element].label;
            var price = data[element].price;
            var valuations = data[element].valuations;

            var html = "<li class='list-group-item'>" +
                "<h3>" + title +
                "</h3>" +
            "<p>Listed at $" + price + "</p>" +
            "<p>Valued at: $" + mean(valuations) +
            "</p>" +
            "<a>Sell For Valuation</a>" +
            "</li>" +
            "<hr>"

            $("#dashboardData").append(html);
        }
    });
    
}

function listSoldItems(){
    $("#dashboardData").empty();
    $.get("/users-endpoint/" + localStorage.getItem("loggedInAs") + "/sold", function(data){

        for (element in data){
            var title = data[element].label;
            var price = data[element].price;
            var valuations = data[element].valuations;

            var html = "<li class='list-group-item'>" +
                "<h3>" + title +
                "</h3>" +
                "<p>Listed at $" + price + "</p>" +
                "<p>Valued at: $" + mean(valuations) +
                "</p>" +
                "</li>" +
                "<hr>"

            $("#dashboardData").append(html);
        }
    });

}