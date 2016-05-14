function search(){
     var value = document.getElementById('search-box').value;

     if(value == null)return; 

   var parameters = { search: value};
  $.get( '/searching', parameters, function(data) {
 
      if(data == null){
      	console.log("No results from search query");
      }
      else{
          var i = 0;
          for(i = 0; i < data.length; i++){
      	console.log(data[i].label);
         }
       }				 
    });
}