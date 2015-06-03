/* jshint devel:true */
var couponList = (function($, window, document) {
  'use strict';

  var couponList = {
    init: function() {
      this.couponData = {};
      this.couponData.coupons = JSON.parse(localStorage.getItem('coupons')) || '';

      this.compileHandlebarsTemplate();
    },
    compileHandlebarsTemplate: function() {
      var source = $('#coupon-list-tmpl').html(),
          template = Handlebars.compile(source),
          html = template(this.couponData);
          
      $('.coupon-list-container').append(html);
    }
  };

  return couponList;
}(jQuery, window, document));