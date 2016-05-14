var numberOfResults = 0;

function search(){
     var value = document.getElementById('search-box').value;

     if(value == null)return; 

   var parameters = { search: value};
  $.get( '/searching', parameters, function(data) {
 
      if(data == null){
      	console.log("No results from search query");
      }
      else{
      		showResults(data);
       }				 
    });
}

function showResults(rows){

	// Remove the old results
	$( ".row-result" ).remove();

	var cur_id = 1;

	var i;
	for(i = 0; i < rows.length; i++){
		var title = rows[i].label;
		var price = rows[i].price;
		var quantity = rows[i].quantity;
		var description = rows[i].description;

	  	var link =  "/documentView?product="+rows[i].sid;//Unique identifier

	  	var stock = "Out of Stock";
	  	var style = "Color:red;"

	  	// If in stock set color to green
	  	if(quantity > 0){
	  		stock = "In Stock";
	  		style = "Color:green;"
	  	}

	  var div = document.createElement("div");
	  div.innerHTML = '<div class="row row-result" id=resultDiv'+cur_id+'><h3><a href='+link+' id=result-header>'+ title+'</a></h3><h4 style="'+style+'">'+stock+'</h4><p><b>$'+price+'</b></p><p >'+description+'</p></div>';

	  var tId = cur_id -1;

	$( div ).insertAfter( $( "#resultDiv"+tId ) ); 

	 cur_id++;
	}
}