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
    $("#dashboardData").append("<h4>Past orders</h4>");
    $.get("/transactions/" + localStorage.getItem("loggedInAs"), function(data){
        if(data.length === 0){
            $("#dashboardData").append("<h4>You haven't ordered anything yet</h4>");
        }
       for (order in data){
           $("#dashboardData").append("<li class='list-group-item' id='" + data[order].tid + "'><h2>Order #" + data[order].tid + "</h2></li>");
           for (product in data[order].products){
               $.get("/product/" + data[order].products[product] + "/raw", function(productData){
                   console.log(productData);
                $("#" + data[order].tid).append("<a href='/product/" + data[order].products[product] + "'>" + productData.title + "</a>");
               });
           }
           $("#" + data[order].tid).append("<hr>");
       }
    });
}

function generateInviteCode(){

    var userid = sessionStorage.getItem("loggedInAs");
    $.post('/invite-code-endpoint', {userid: userid}, function(data){
        $("#inviteCode").text(data.rows[0].code);
        codeGenerated = true;
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
    console.log("LISTING ITEMS FOR SALE");
    $("#dashboardData").empty();

    var valuationsRequired;
    var votesRequired;
    $.get("/parameters/valuations-required", function(valuationData) {
        valuationsRequired = valuationData.value;


        $.get("/parameters/votes-required", function(voteData) {
            votesRequired = voteData.value;

            $.get("/users-endpoint/" + localStorage.getItem("loggedInAs") + "/forsale", function (data) {

                if(data.length === 0){
                    $("#dashboardData").append("<h4>You don't have any current listings</h4>");
                } else {
                    $("#dashboardData").append("<h4>Listed Products</h4>");
                }


                for (element in data) {
                    var title = data[element].label;
                    var id = data[element].sid;
                    var price = data[element].price;
                    var valuations = data[element].valuations;
                    var totalValuations = valuations.length;
                    var sellingAtList = data[element].selling_at_list;
                    var status = data[element].status;
                    var votes = data[element].votes;
                    console.log(sellingAtList);

                    var html = "<li class='list-group-item'>" +
                        "<h3><a href='/product/%HREF%'>".replace("%HREF%", id) + title +
                        "</h3></a>" +
                        "<h4>Listed at $" + price + "</h4>" +
                        "<p>Valued at: $" + mean(valuations) +
                        " (based on valuations provided by %N% other members)</p>".replace("%N%", totalValuations) +
                        "%VALUATION%" +
                        "<br>" +
                        "</li>" +
                        "<hr>"

                    console.log(totalValuations);
                    console.log(valuationsRequired);
                    if (totalValuations >= valuationsRequired){
                        html = html.replace("%VALUATION%", "<a class='btn btn-primary' id='valuation' onclick='sellForValuation(%ID%)'>Sell For Valuation</a>".replace("%ID%", id));
                    } else {
                        html = html.replace("%VALUATION%", "<p><i>Requires %N% more valuations before the community price can be selected</i></p>".replace("%N%", valuationsRequired-totalValuations));
                    }

                    if (!sellingAtList){
                         html = "<li class='list-group-item'>" +
                            "<h3><a href='/product/%HREF%'>".replace("%HREF%", id) + title +
                            "</h3></a>" +
                            "<p><strike>Listed at $" + price + "</strike></p>" +
                            "<h4 style='Color:green'>Valued at: $" + mean(valuations) +
                            "</h4>" +
                                 "<p><i>Selling at the mean valuation price based on valuations submitted by %N% members</i></p>".replace("%N%", totalValuations)+
                            "<br>" +
                            "</li>" +
                            "<hr>"
                    }

                    if (status === 'pending'){
                        html = "<li class='list-group-item'>" +
                            "<h3><a href='/product/%HREF%'>".replace("%HREF%", id) + title +
                            "</h3></a>" +
                            "<h4>Listed at $" + price + "</h4>" +
                            "<p><i>Requires %N% more votes</p></i></p>".replace("%N%", votesRequired-votes)+
                            "<br>" +
                            "</li>" +
                            "<hr>"
                    }

                    $("#dashboardData").append(html);
                }
            });
        });
    });
}

function listSoldItems(){
    $("#dashboardData").empty();
    $.get("/users-endpoint/" + localStorage.getItem("loggedInAs") + "/sold", function(data){
        if(data.length === 0){
            $("#dashboardData").append("<h4>You haven't sold anything yet</h4>");
        }else {
            $("#dashboardData").append("<h4>Sold Products</h4>");
        }


        for (element in data){
            var title = data[element].label;
            var id = data[element].sid;
            var price = data[element].price;
            var valuations = data[element].valuations;
            var list = data[element].selling_at_list;



            if (list){
                var html = "<li class='list-group-item'>" +
                    "<h3><a href='%HREF%'>".replace("%HREF%", "/product/" + id) + title + "</a></h3>" +
                    "<h4>Sold for $" + price + "</h4>" +
                    "<p>This product sold at its listed price</p>" +
                    "<br>" +
                    "</li>"+
                    "<hr>"

            } else {
                var html = "<li class='list-group-item'>" +
                    "<h3><a href='%HREF%'>".replace("%HREF%", "/product/" + id) + title + "</a></h3>" +
                    "<h4>Sold for $" + price + "</h4>" +
                    "<p>This product sold at its valued price</p>" +
                    "<br>" +
                    "</li>"+
                    "<hr>"
            }



            $("#dashboardData").append(html);
        }
    });

}

function listRejectedProducts(){
    $("#dashboardData").empty();

    $("#dashboardData").append("<h4>Rejected Listings</h4>");
    $.get("/users-endpoint/" + localStorage.getItem("loggedInAs") + "/unsuccessful", function(data){

        for (element in data){
            var title = data[element].label;
            var id = data[element].sid;
            var price = data[element].price;
            var valuations = data[element].valuations;

            var html = "<li class='list-group-item'>" +
                "<h3><a href='%HREF%'>".replace("%HREF%", "/product/" + id) + title + "</a></h3>" +
                "<p>Listed at $" + price + "</p>" +
                "</p>" +
                "<p>This product did not receive sufficient votes</p>"+
                "</li>" +
                "<hr>"

            $("#dashboardData").append(html);

        }
        listDeletedProducts();
    });
}

function listDeletedProducts(){
    $.get("/users-endpoint/" + localStorage.getItem("loggedInAs") + "/deleted", function(data){

        for (element in data){
            var title = data[element].label;
            var price = data[element].price;
            var id = data[element].sid;
            var valuations = data[element].valuations;

            var html = "<li class='list-group-item'>" +
                "<h3><a href='%HREF%'>".replace("%HREF%", "/product/" + id) + title + "</a></h3>" +
                "</h3>" +
                "<p>Listed at $" + price + "</p>" +
                "<p>Valued at: $" + mean(valuations) +
                "</p>" +
                "<p>This product was deleted by an administrator</p>"+
                "</li>" +
                "<hr>"

            $("#dashboardData").append(html);
        }
    });

}

function sellForValuation(productID){
    $.post("/product/" + productID + "/setvaluation", function(data){
        console.log("UPDATED SELL FOR VALUATION");
        listItemsForSale();
    });
}