/* jshint devel:true */
var admin = (function($, window, document) {
  'use strict';

  var admin = {
    init: function() {
      this.couponData = JSON.parse(localStorage.getItem('coupons')) || '';
    }
  };

  return admin;
}(jQuery, window, document));