var advanced = false;


function toggleAdvanced(){
	advanced = !advanced;
}

function serialise(obj) {
	var str = [];
	for(var p in obj)
		if (obj.hasOwnProperty(p)) {
			str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
		}
	return str.join("&");
}


function search(){
     var value = document.getElementById('search-box').value;

     if(value == null)return; 

     // Advanced search variables
    var cat = $('#sel-catagory :selected').text();
    var min =  $('#min-price').val();
    var max =  $('#max-price').val();
    var valued = $("#chk-stock").is(':checked');
	var category = $("#category").val();
    var isExpanded = $("#filter-panel").attr("aria-expanded");

   var parameters = { q: value,
   					   category: category,
   					   minPrice:min,
   					   maxPrice:max,
   					   valued:valued,
   					   adv:advanced
   					};

	console.log();
	window.location.replace("/search?" + serialise(parameters));
}


$(document).ready( function() {
 $('#main-search').on('keyup keypress', function(e) {
    var keyCode = e.keyCode || e.which;
    if (keyCode === 13) { 
      e.preventDefault();
      search();
      return false;
    }
});
});
