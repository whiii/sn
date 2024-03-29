// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function (){
 	$("#status_label").live("click", function (){
    $("#status_label").hide();
    $("#status_input").show();
    $("#status_input").focus();
  });
  $("#status_input").live("blur", function (){
    $("#status_form").submit();
  });
  $("#status_form").live("submit", function (){
    $("#status_input").hide();
    $("#status_label").show();
  })

  $("#wall_messages_container .pagination a").live("click", function() {
    $.getScript($("#wall_messages_container").attr("data-wall-messages-url")+"?"+this.href.split("?")[1]);
    return false;
  });

  $.each($(".fusionchart"), function(){
    FusionCharts._fallbackJSChartWhenNoFlash();
    var chart_id = this.getAttribute("data-id");
    var url = this.getAttribute("data-url");
    var chart_name = this.getAttribute("data-chart");
    var chart_width = this.getAttribute("data-width");
    var chart_height = this.getAttribute("data-height");
    this.id = chart_id + "_container";
    var container_id = this.id;
    $.get(url, null, function(dataXML){
      xmlString = (new XMLSerializer()).serializeToString(dataXML);;
      var chart_path = "FusionCharts/"+chart_name+".swf";
      var chart = new FusionCharts(chart_path, chart_id, chart_width, chart_height);
      chart.setXMLData(xmlString);
      chart.render(container_id);
    }, "xml");    
  })
})

$(function() {
  $("#lightbox_gallery a.gallery_item").lightBox(); // Select all links in object with gallery ID
  $(".datepicker").datepicker({ dateFormat: 'yy-mm-dd' });
  $("#charts").tabs();
});