
shinyjs.pageCol = function(params) {
  $('body').css('background', params);
};

/*
shinyjs.init = function() {
  $(document).keypress(function(e) { alert('Key pressed: ' + e.which); });
};
*/

shinyjs.backgroundCol = function(params) {
  var defaultParams = {
    id : null,
    col : "red"
  };
  params = shinyjs.getParams(params, defaultParams);

  var el = $("#" + params.id);
  el.css("background-color", params.col);
};
