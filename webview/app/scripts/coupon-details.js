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
      var couponId = this.getQueryString('id');

      this.couponDetails = this.couponData[0];
    },
    getQueryString: function(name) {
      name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
      var regex = new RegExp('[\\?&]' + name + '=([^&#]*)'),
          results = regex.exec(location.search);
      return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    },
    parseFlightDate: function() {
      this.couponDetails.flight.flightDate = moment(this.couponDetails.flight.departure).format('ddd, MMM DD YYYY');
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