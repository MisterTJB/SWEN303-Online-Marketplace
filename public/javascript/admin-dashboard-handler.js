var selectedPath;

function ltreeToJSON(input){
    var output = [];
    for (var i = 0; i < input.length; i++) {
        var chain = input[i].split(".");
        var currentNode = output;
        for (var j = 0; j < chain.length; j++) {
            var wantedNode = chain[j];
            var lastNode = currentNode;
            for (var k = 0; k < currentNode.length; k++) {
                if (currentNode[k].text == wantedNode.replace(/_/g, " ")) {
                    currentNode = currentNode[k].nodes;
                    break;
                }
            }
            // If we couldn't find an item in this list of children
            // that has the right name, create one:
            if (lastNode == currentNode) {
                var newNode = currentNode[k] = {text: wantedNode.replace(/_/g, " "), nodes: []};
                currentNode = newNode.nodes;
            }
        }
    }
    return output;
}

$(document).ready(function(){
});


function selectedCategoryToLTreePathRecursive(node){
    //
    // return $("#tree").treeview('getParent', node).nodes;

    if (!$("#adminTree").treeview('getParent', node).nodes){
        return [node.text]
    }
    //else {
    //     selectedCategoryToLTreePath($("#tree").treeview('getParent', node));
    // }
    else {
        var nodes = selectedCategoryToLTreePathRecursive($("#adminTree").treeview('getParent', node));
        nodes.push(node.text);
        return nodes;
    }
}

function selectedCategoryToLTreePath(node){
    return selectedCategoryToLTreePathRecursive(node).join(".").replace(/ /g, "_");
}

function displayCategoryTree(){
    $("#dashboardData").empty();
    html =
        '<h4>Select A Category</h4>'+
        '<div id="adminTree"></div>' +

        '<button type="button" class="btn btn-success" data-toggle="modal" data-target="#addModal" data-whatever="@mdo">Add</button>' +
        '<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#removeModal" data-whatever="@fat">Remove</button>'
    $("#dashboardData").append(html);
    $.get("/categories/permitted", function(data){

        $('#adminTree').treeview({
            data: ltreeToJSON(data),
            levels: 0,
            onNodeSelected: function(event, node) {
                $("#category").attr("value", selectedCategoryToLTreePath(node))}
        });
    });
}

function displayProductComplaints(){
    $("#dashboardData").empty();

    var html = "<h4>Complaints About Products</h4>";
    $.get("/complaints/product", function(data){
        for (complaint in data){

            var complaintHTML = "<li class='list-group-item' id='pComplaint%CID%'>".replace("%CID%", data[complaint].cid) +
                "<h3><a href='/product/%HREF%'>".replace("%HREF%", data[complaint].pid) + data[complaint].label + "</a>" +
                "</h3>" +
                "<p>"  + data[complaint].complaint + "</p>" +
                    "<p>Authored by: " + data[complaint].username + "</p>" +
                    "<a class='btn btn-danger' onclick='deleteProduct(%PID%, %CID%)'>Delete Product</a>".replace("%PID%", data[complaint].pid).replace("%CID%", data[complaint].cid) +
                    "<a class='btn btn-info' onclick='reviewedProductComplaint(%CID%)'>Dismiss</a>".replace("%CID%", data[complaint].cid) +
                "</li>" +
                "<hr>"


            html = html + complaintHTML;
        }
        $("#dashboardData").append(html);
    });
}

function displayMemberComplaints(){
    $("#dashboardData").empty();

    var html = "<h4>Complaints About Members</h4>";
    $.get("/complaints/user", function(data){
        for (complaint in data){

            var complaintHTML = "<li class='list-group-item' id='mComplaint%CID%'>".replace("%CID%", data[complaint].cid) +
                "<h3 id='username'>" + data[complaint].username +
                "</h3>" +
                "<p>"  + data[complaint].complaint + "</p>" +
                "<p>Authored by: " + data[complaint].complainant + "</p>" +
                "<a class='btn btn-danger' onclick='deleteMember(%CID%)'>Delete Member</a>".replace("%CID%", data[complaint].cid) +
                "<a class='btn btn-info' onclick='reviewedUserComplaint(%CID%)'>Dismiss</a>".replace("%CID%", data[complaint].cid) +
                "<hr>" +
            "</li>"



            html = html + complaintHTML;
        }
        $("#dashboardData").append(html);
    });
}

function reviewedUserComplaint(cid){
    $.post("/complaints/user/complaint/" + cid);
    $("#mComplaint" + cid).remove();

}

function reviewedProductComplaint(cid){
    $.post("/complaints/product/complaint/" + cid);
    $("#pComplaint" + cid).remove();
}

function deleteMember(cid){

    $.post("/users-endpoint/" + username + "/delete/");
    reviewedUserComplaint(cid);
}

function deleteProduct(pid, cid){
    $.post("/product/" + pid + "/delete/");
    reviewedProductComplaint(cid);
}


function deleteCategory(deleteListings){
    console.log("Delete everything: " + deleteListings);

    if(deleteListings){
        $.post("/categories/delete", {category: $("#category").val()}, function(data){
            displayCategoryTree();
        });

    } else {
        $.post("/categories/permitted/remove", {category: $("#category").val()}, function(data){
            displayCategoryTree();
        });
    }
}

function addSibling(){
    console.log("Add sibling");
    // new category is category.split(".").slice(0, category.split(".").length - 1).join(".") + $(#newName)
    var category = $("#category").val();
    var newCategory = category.split(".").slice(0, category.split(".").length -1).join(".") + "." + $("#new-category").val();
    newCategory = newCategory.replace(/ /g, "_");
    console.log(newCategory);
    $.post("/categories/permitted/add", {category: newCategory}, function(data){
        displayCategoryTree();
        $("#new-category").val('');
    });
}

function addChild(){
    console.log("Add child");
    var newCategory = $("#category").val()  + "." + $("#new-category").val().replace(/ /g, "_");
    console.log(newCategory);
    $.post("/categories/permitted/add", {category: newCategory}, function(data){
        displayCategoryTree();
        $("#new-category").val('');
    });

}

function voting(){
    $("#dashboardData").empty();

    $.get("/parameters/votes-required", function(data){
        $("#dashboardData").append("<h4>Set Votes Required</h4><p>The site is currently set to require %N% votes before a listing enters the marketplace</p>".replace("%N%", data.value));

        var html = '<div class="col-lg-6">'+
            '<div class="input-group">'+
            '<input type="text" class="form-control" id="votesInput" placeholder="Set a new value">'+
            '<span class="input-group-btn">'+
            '<button class="btn btn-primary" type="button" onclick="updateVotes()">Update</button>'+
        '</span>'+
        '</div>'+
        '</div>'
        $("#dashboardData").append(html);
    });
}

function valuation(){
    $("#dashboardData").empty();

    $.get("/parameters/valuations-required", function(data){
        $("#dashboardData").append("<h4>Set Valuations Required</h4><p>The site is currently set to require %N% valuations before a seller may sell at the valued price</p>".replace("%N%", data.value));
        var html = '<div class="col-lg-6">'+
            '<div class="input-group">'+
            '<input type="text" class="form-control" id="valuationInput"  placeholder="Set a new value">'+
            '<span class="input-group-btn">'+
            '<button class="btn btn-primary" onclick="updateValuation()" type="button">Update</button>'+
            '</span>'+
            '</div>'+
            '</div>'
        $("#dashboardData").append(html);
    });
}

function newQueue(){
    $("#dashboardData").empty();

    $.get("/parameters/queue-length", function(data){
        $("#dashboardData").append("<h4>Set New Queue Length</h4><p>The site is set to purge the oldest product from the <a href='/new'>new listings</a> queue whenever it contains %N% products</p>".replace("%N%", data.value));
        var html = '<div class="col-lg-6">'+
            '<div class="input-group">'+
            '<input type="text" class="form-control" id="newQueueInput" placeholder="Set a new value">'+
            '<span class="input-group-btn">'+
            '<button class="btn btn-primary" type="button" onclick="updateNewQueue()">Update</button>'+
            '</span>'+
            '</div>'+
            '</div>'
        $("#dashboardData").append(html);
    });
}

function updateVotes(){
    var newValue = $("#votesInput").val();
    console.log(newValue);
    $.post("/parameters/votes-required/" + newValue);
    voting();
}

function updateValuation(){
    var newValue = $("#valuationInput").val();
    console.log(newValue);
    $.post("/parameters/valuations-required/" + newValue);
    valuation();

}

function updateNewQueue(){
    var newValue = $("#newQueueInput").val();
    console.log(newValue);
    $.post("/parameters/queue-length/" + newValue);
    newQueue();
}