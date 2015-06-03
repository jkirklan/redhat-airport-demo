/* jshint devel:true */
var couponDetails = (function($, window, document) {
  'use strict';

  var couponDetails = {
    init: function() {
      this.couponData = JSON.parse(localStorage.getItem('coupons')) || '';

      this.compileHandlebarsTemplate();
    },
    getCouponDetails: function() {
      // Use query string 
    },
    compileHandlebarsTemplate: function() {
      var source = $('#coupon-details-tmpl').html(),
          template = Handlebars.compile(source),
          html = template(this.couponData);
          
      $('.coupon-details-container').append(html);
    }
  };

  return couponDetails;
}(jQuery, window, document));