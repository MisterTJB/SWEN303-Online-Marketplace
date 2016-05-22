/**
 * Provides functions for implementing client-side functionality within the user dashboard
 */

var codeGenerated = false;

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
    var sum = list.reduce(function(a, b){return a+b;});
    return sum/list.length;
}

function listItemsForSale(){
    
    $.get("users-endpoint/" + localStorage.getItem("loggedInAs") + "/forsale", function(data){

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