/* jshint devel:true */
var couponDetails = (function($, window, document) {
  'use strict';

  var couponDetails = {
    init: function() {
      this.couponData = JSON.parse(localStorage.getItem('coupons')) || '';

      this.getCouponDetails();
      this.parseFlightDate();
      this.compileHandlebarsTemplate();
    },
    getCouponDetails: function() {
      var couponId = parseInt(home.getQueryString('id'));

      this.couponDetails = this.couponData[couponId];
    },
    parseFlightDate: function() {
      this.couponDetails.flightDate = moment(this.couponDetails.departure).format('ddd, MMM DD YYYY');
    },
    compileHandlebarsTemplate: function() {
      var source = $('#coupon-details-tmpl').html(),
          template = Handlebars.compile(source),
          html = template(this.couponDetails);
          
      $('.coupon-details-container').append(html);
    }
  };

  return couponDetails;
}(jQuery, window, document));