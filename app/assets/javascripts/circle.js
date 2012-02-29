$(document).ready(function() {
  $('.users-table table').dataTable({
    "bJQueryUI": true,
    "aoColumns":[
      { "bSortable": false},
      null,
      null,
      null,
      null,
    ]
  });
 $('.multi-select').multiselect({
    open:function(event, ui){
      var writableCircles=JSON.parse($("#writable-circles").html())||[];
      $('.ui-multiselect-menu input[type=checkbox]').each(function(){
        if (!writableCircles[this.value])
          $(this).attr("disabled","disabled");
    });
    },
    beforeclose:function(){
      $(this).parent("form").submit();
    },
    close:function(){
      $(this).multiselect("refresh");
    },
  });
  $('.multi-select-box').multiselect_box({close:function(){
  }});


  var urlStart = "?";
  // get the current URL in the address bar.
  var urlGet = window.location.toString();
    
  // if the address bar URL does not have ?find_loc=Mexico+City,+Distrito+Federal then add it to its end.
  if(-1 === urlGet.indexOf("?")){
    var url = urlGet + urlStart;
  }else{
    var url = urlGet;
  }

  $('.filters input[type=checkbox]').button().change(function(){
      
    // a GET request will be of the form: "...search-result_new.html?find_loc=Mexico+City,+Distrito+Federal&name1=keyword1+keyword2+keyword3+&name2=keyword4+...."
    var name = $(this).parent().parent().attr('id');
    name = name.replace(/\s/g, "");
    var keyword = $(this).attr('name');
    keyword = keyword.replace(/\s/g, "");
    if (keyword === 'all') {
      keyword = '';
      var regx = new RegExp("\&"+name+"[^\&]*",'g');
      url = url.replace(regx, "");
      window.location.href = url;
    }
    // if the address bar URL does not contain our name, then add it to its end.
    if(-1 === url.indexOf(name)) 
      url += '&' + name + "=";
      
    // If the address bar URL does not contain our keyword, find its name, and add it to its end. Eg: delivery+ or opennow+ after Feature=
    if(-1 === url.indexOf(keyword)){ 
      var urlGen = name + "=" + keyword + ",";
      var urlGen1 = name + "=" + keyword;
      var urlGen2 = name + "=";
      
      // if it is the fir st keyword, dont add the comma in the end. if ( (some other name starts after this name) or (this name is the last one in the url) )
      if(('&' == url.charAt(url.indexOf(urlGen2) + urlGen2.length))||(url.length == (url.indexOf(urlGen2) + urlGen2.length)))
        url = url.replace(urlGen2,urlGen1);
      else
        url = url.replace(urlGen2,urlGen);
      
        
    }else{ 
    //If it does contain our keyword, remove it.
      var urlGen = keyword + ",";
      var urlGen1 = "," + keyword;
      var urlGen2 = "&" + name + "=";
      
      // if there is a , after the keyword, remove the keyword and comma. Otherwise remove the keyword and the comma before it!
      if(',' == url.charAt(url.indexOf(keyword) + keyword.length))
        url = url.replace(urlGen,"");
      else{
        var num = url.indexOf(keyword) - 1;
        if(',' == url.charAt(num))
          url = url.replace(urlGen1,"");
        else
          url = url.replace(keyword,"");
      }
      
      // if it is the last keyword, get rid of the name as well
      if(('&' == url.charAt(url.indexOf(urlGen2) + urlGen2.length))||(url.length == (url.indexOf(urlGen2) + urlGen2.length)))
        url = url.replace(urlGen2,"");
    }
    // where the magic happens.
    window.location.href = url;
  });

});