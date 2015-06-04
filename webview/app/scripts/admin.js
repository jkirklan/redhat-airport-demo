/* jshint devel:true */
var admin = (function($, window, document) {
  'use strict';

  var admin = {
    init: function() {
      this.resetButtonListener();
      this.flightTimerButtonListener();
      this.resetCouponButtonListener();
    },
    resetButtonListener: function() {
      $('.reset-btn').on('click',function() {
        localStorage.clear();
        // Send api call to reset here
        // 
        alert('Demo has been reset');
      });
    },
    flightTimerButtonListener: function() {
      $('.timer-btn').on('click', function() {
        localStorage.setItem('demoMode', 'true');
        alert('Delayed flight timer on');
      });
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