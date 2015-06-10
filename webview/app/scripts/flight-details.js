/* jshint devel:true */
var flightDetails = (function($, window, document) {
  'use strict';

  var flightDetails = {
    init: function() {
      this.flightData = this.getFlightData();

      this.parseFlightDate();
      this.parseFlightTimes();

      this.compileHandlebarsTemplate();
      this.checkFlightStatus();
      this.checkCouponStatus();
      this.saveCouponButtonListener();
    },
    getFlightData: function() {
      var flightData = JSON.parse(localStorage.getItem('flightData'));
      
      return flightData;
    },
    compileHandlebarsTemplate: function() {
      var source = $('#flight-details-tmpl').html(),
          template = Handlebars.compile(source),
          html = template(this.flightData);

      $('.main-container').append(html);
    },
    parseFlightDate: function() {
      this.flightData.flightDate = moment(this.flightData.departure).format('ddd, MMM DD YYYY');
    },
    parseFlightTimes: function() {
      this.flightData.departureTime = moment(this.flightData.departure).format('HH:mm');
      this.flightData.arrivalTime = moment(this.flightData.arrival).format('HH:mm');
      this.flightData.boardingTime = moment(this.flightData.boarding).format('HH:mm');
    },
    checkFlightStatus: function() {
      var $flightStatus = $('.flight-status');

      if (this.flightData.flightStatus === 'On Time') {
        $flightStatus.addClass('success-bg');
      }
      else if (this.flightData.flightStatus === 'Delayed') {
        $flightStatus.addClass('failure-bg');
      }
      else if (this.flightData.flightStatus === 'Changed') {
        $flightStatus.addClass('failure-bg');
      }
    },
    checkCouponStatus: function() {
      var $couponSavedMessage = $('.coupon-saved-area'),
          $coupon = $('.coupon-area'),
          coupons = JSON.parse(localStorage.getItem('coupons')) || '';

      if (coupons.length) {
        $coupon.hide();
        $couponSavedMessage.show();
      }
      else {
        $coupon.show();
        $couponSavedMessage.hide();
      }
    },
    saveCouponButtonListener: function() {
      var that = this,
          $couponSaveBtn = $('.coupon-save-btn'),
          $couponSavedMessage = $('.coupon-saved-area'),
          $coupon = $('.coupon-area');

      $couponSaveBtn.on('click', function() {
        var newCoupons = JSON.parse(localStorage.getItem('coupons'));

        $coupon.hide();
        $couponSavedMessage.show();

        // Push new coupons saved into local storage object
        newCoupons.push(that.flightData);
        localStorage.setItem('coupons', JSON.stringify(newCoupons));
      });
    }
  };

  return flightDetails;
}(jQuery, window, document));