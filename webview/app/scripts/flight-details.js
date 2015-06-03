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
      // var request = $.ajax({
      //   url: '',
      //   method: 'POST',
      //   data: { id : 257 }
      // });
      
      // request.done(function(data) {
      //   console.log(data);
      // });
      
      // request.fail(function(jqXHR, textStatus) {
      //   console.log('Request failed: ' + textStatus);
      // });
      
      var mockData = {
        'flight': {
            'flightNo': 70,
            'airlineCode': 'AC',
            'departure': '2015-06-02T12:00',
            'arrival': '2015-06-04T13:45',
            'boarding': '2015-06-02T11:40',
            'startingAirport': 'BOS',
            'destinationAirport': 'YYZ',
            'startingCity': 'Boston',
            'destinationCity': 'Toronto',
            'flightStatus': 'On Time',
            'startingGate': 1,
            'destinationGate': 1
        },
        'coupon': {
          'id': 1,
          'path': 'images/starbucks-coupon.png',
          'offer': '1 Free Starbucks Coffee',
          'description': 'Redeem this coupon at any Starbucks Coffee location at Logan International Airport.'
        }
      };
      
      return mockData;
    },
    compileHandlebarsTemplate: function() {
      var source = $('#flight-details-tmpl').html(),
          template = Handlebars.compile(source),
          html = template(this.flightData);

      $('.main-container').append(html);
    },
    parseFlightDate: function() {
      this.flightData.flight.flightDate = moment(this.flightData.flight.departure).format('ddd, MMM DD YYYY');
    },
    parseFlightTimes: function() {
      this.flightData.flight.departureTime = moment(this.flightData.flight.departure).format('HH:mm');
      this.flightData.flight.arrivalTime = moment(this.flightData.flight.arrival).format('HH:mm');
      this.flightData.flight.boardingTime = moment(this.flightData.flight.boarding).format('HH:mm');
    },
    checkFlightStatus: function() {
      var $flightStatus = $('.flight-status');

      if (this.flightData.flight.flightStatus === 'On Time') {
        $flightStatus.addClass('success');
      }
      else if (this.flightData.flight.flightStatus === 'Delayed') {
        $flightStatus.addClass('failure');
      }
      else if (this.flightData.flight.flightStatus === 'Changed') {
        $flightStatus.addClass('failure');
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
          $couponSavedMessage = $('.coupon-saved-area'),
          $coupon = $('.coupon-area');

      $('.coupon-btn').on('click', function() {
        var newCoupons = JSON.parse(localStorage.getItem('coupons'));

        $coupon.hide();
        $couponSavedMessage.show();

        newCoupons.push(that.flightData);
        localStorage.setItem('coupons', JSON.stringify(newCoupons));
      });
    }
  };

  return flightDetails;
}(jQuery, window, document));