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
    console.log("Getting categories");



});


function selectedCategoryToLTreePathRecursive(node){
    //
    // return $("#tree").treeview('getParent', node).nodes;

    if (!$("#tree").treeview('getParent', node).nodes){
        return [node.text]
    }
    //else {
    //     selectedCategoryToLTreePath($("#tree").treeview('getParent', node));
    // }
    else {
        var nodes = selectedCategoryToLTreePathRecursive($("#tree").treeview('getParent', node));
        nodes.push(node.text);
        return nodes;
    }
}

function selectedCategoryToLTreePath(node){
    return selectedCategoryToLTreePathRecursive(node).join(".").replace(/ /g, "_");
}

function displayCategoryTree(){
    $("#dashboardData").empty();
    html = '<div id="tree"></div>' +
        '<form>' +
        '<a>Rename</a>' +
        '<a>Delete</a>' +
        '<a>Add Sibling</a>' +
    '<a>Add Child</a>' +
    '</form>'
    $("#dashboardData").append(html);
    $.get("/categories", function(data){
        $('#tree').treeview({
            data: ltreeToJSON(data),
            levels: 0,
            onNodeSelected: function(event, node) {
                $("#category").attr("value", selectedCategoryToLTreePath(node))}
        });
    });
}

function displayProductComplaints(){
    $("#dashboardData").empty();

    var html = "";
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

    var html = "";
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