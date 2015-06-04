/* jshint devel:true */
var admin = (function($, window, document) {
  'use strict';

  var admin = {
    init: function() {
      this.resetCouponButtonListener();
    },
    resetCouponButtonListener: function() {
      $('.clear-coupons-btn').on('click', function() {
        localStorage.removeItem('coupons');
        alert('Saved coupons have been cleared');
      });
    }
  };

  return admin;
}(jQuery, window, document));