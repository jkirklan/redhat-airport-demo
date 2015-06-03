/* jshint devel:true */
var home = (function($, window, document) {
  'use strict';

  var home = {
    init: function() {
      this.flightData = this.getFlightData();

      this.parseDepartureTime();

      this.compileHandlebarsTemplate();
      this.checkFlightStatus();
      this.createCouponStorage();
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
      var source = $('#current-flight-tmpl').html(),
          template = Handlebars.compile(source),
          html = template(this.flightData);

      $('.current-flight').append(html);
    },
    parseDepartureTime: function() {
      this.flightData.flight.departureTime = moment(this.flightData.flight.departure).calendar(new Date());
    },
    checkFlightStatus: function() {
      var $departureTime = $('.current-flight-departure'),
          $flightStatus = $('.current-flight-status');

      if (this.flightData.flight.flightStatus === 'On Time') {
        $departureTime.addClass('success');
        $flightStatus.addClass('success');
      }
      else if (this.flightData.flight.flightStatus === 'Delayed') {
        $departureTime.addClass('failure');
        $flightStatus.addClass('failure');
      }
      else if (this.flightData.flight.flightStatus === 'Changed') {
        $departureTime.addClass('failure');
        $flightStatus.addClass('failure');
      }
    },
    createCouponStorage: function() {
      if (!localStorage.getItem('coupons')) {
        localStorage.setItem('coupons', JSON.stringify([]));
      }
    }
  };

  return home;
}(jQuery, window, document));