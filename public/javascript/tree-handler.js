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

    $.get("/categories", function(data){
       console.log(data);
        $('#tree').treeview({
            data: ltreeToJSON(data),
            levels: 0,
            onNodeSelected: function(event, node) {
                selectedPath = selectedCategoryToLTreePath(node)}
    });
    });

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