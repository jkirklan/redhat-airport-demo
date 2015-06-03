/* jshint devel:true */
var couponList = (function($, window, document) {
  'use strict';

  var couponList = {
    init: function() {
      
      
      this.compileHandlebarsTemplate();
    },
    getFlightData: function() {
    },
    compileHandlebarsTemplate: function() {
      var source = $('#coupon-list-tmpl').html(),
          template = Handlebars.compile(source),
          html = template(this.flightData);

      $('.main-container').append(html);
    }
  };

  return couponList;
}(jQuery, window, document));