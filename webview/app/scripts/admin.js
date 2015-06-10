/* jshint devel:true */
var admin = (function($, window, document) {
  'use strict';

  var admin = {
    init: function() {
      this.resetButtonListener();
      this.flightTimerButtonListener();
      this.resetCouponButtonListener();
      this.startBeaconButtonListener();
      this.stopBeaconButtonListener();
    },
    resetButtonListener: function() {
      $('.reset-btn').on('click',function() {
        localStorage.clear();
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
    },
    startBeaconButtonListener: function() {
      $('.start-beacon-btn').on('click', function() {
        $.ajax({
          url: 'http://redhatairportdemo-fguanlao.rhcloud.com/rest/digitalSignage',
          data: { showDetails: true },
          method: 'POST'
        }).done(function() {
          alert('Beacon started');
        }).fail(function(jqXHR, textStatus, error) {
          alert('Beacon start failed');
          console.log(error);
        });
      });
    },
    stopBeaconButtonListener: function() {
      $('.stop-beacon-btn').on('click', function() {
        $.ajax({
          url: 'http://redhatairportdemo-fguanlao.rhcloud.com/rest/digitalSignage',
          data: { showDetails: false },
          method: 'POST'
        }).done(function() {
          alert('Beacon stopped');
        }).fail(function(jqXHR, textStatus, error) {
          alert('Beacon stop failed');
          console.log(error);
        });
      });
    }
  };

  return admin;
}(jQuery, window, document));