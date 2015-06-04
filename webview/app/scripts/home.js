/* jshint devel:true */
var home = (function($, window, document) {
  'use strict';

  var home = {
    init: function() {
      this.setDemoMode();

      this.parseDepartureTime();
      this.compileHandlebarsTemplate();
      this.checkFlightStatus();
      this.createCouponStorage();
    },
    setDemoMode: function() {
      var that = this;

      if (localStorage.getItem('demoMode') === 'true') {
        this.flightData = this.getFlightData(false);
        setTimeout(function() {
          that.flightData = that.getFlightData(true);
          $('.current-flight').children().not('#current-flight-tmpl').remove();
          that.parseDepartureTime();
          that.compileHandlebarsTemplate();
          that.checkFlightStatus();
          localStorage.setItem('demoMode', 'false');
        }, 5000);
      }
      else {
        this.flightData = this.getFlightData(false);
      }
    },
    getFlightData: function(demoMode) {
      var flightData,
          request,
          url;

      url = demoMode ? '/rest/flightStatus/70?demoMode=true' : '/rest/flightStatus/70';

      // request = $.ajax({
      //   url: url,
      //   method: 'GET'
      // });
      
      // request.done(function(data) {
      //   mockData = data;
      // });
      
      // request.fail(function(jqXHR, textStatus) {
      //   console.log('Request failed: ' + textStatus);
      // });
      
      if (demoMode === true) {
        flightData = {
          'flightNo': 70,
          'airlineCode': 'AC',
          'departure': '2015-06-02T12:00',
          'arrival': '2015-06-02T13:45',
          'boarding': '2015-06-02T11:40',
          'startingAirport': 'BOS',
          'destinationAirport': 'YYZ',
          'startingCity': 'Boston',
          'destinationCity': 'Toronto',
          'flightStatus': 'Delayed',
          'startingGate': 1,
          'destinationGate': 1,
          'coupon': {
              'id': 0,
              'company': 'Starbucks',
              'companyCode': 'STBK',
              'path': 'images/starbucks-coupon.png',
              'offer': 'Get 1 Free Starbucks Coffee',
              'description': 'Redeem this coupon at any Starbucks Coffee location at Boston Logan International.',
              'delaySeverity': 60,
              'statusId': 2
          }
        };
      }
      else {
        flightData = {
          'flightNo': 70,
          'airlineCode': 'AC',
          'departure': '2015-06-02T12:00',
          'arrival': '2015-06-02T13:45',
          'boarding': '2015-06-02T11:40',
          'startingAirport': 'BOS',
          'destinationAirport': 'YYZ',
          'startingCity': 'Boston',
          'destinationCity': 'Toronto',
          'flightStatus': 'On Time',
          'startingGate': 1,
          'destinationGate': 1,
          'coupon': null
        };
      }

      localStorage.setItem('flightData', JSON.stringify(flightData));
      
      return flightData;
    },
    compileHandlebarsTemplate: function() {
      var source = $('#current-flight-tmpl').html(),
          template = Handlebars.compile(source),
          html = template(this.flightData);

      $('.current-flight').append(html);
    },
    parseDepartureTime: function() {
      this.flightData.departureTime = moment(this.flightData.departure).calendar(new Date());
    },
    checkFlightStatus: function() {
      var $departureTime = $('.current-flight-departure'),
          $flightStatus = $('.current-flight-status');

      if (this.flightData.flightStatus === 'On Time') {
        $departureTime.addClass('success-color');
        $flightStatus.addClass('success-bg');
      }
      else if (this.flightData.flightStatus === 'Delayed') {
        $departureTime.addClass('failure-color');
        $flightStatus.addClass('failure-bg');
        $flightStatus.addClass('failure-bg-get-coupon');
        $flightStatus.parent().append('<div class="get-coupon">Get Coupon</div>');
      }
      else if (this.flightData.flightStatus === 'Changed') {
        $departureTime.addClass('failure-color');
        $flightStatus.addClass('failure-bg');
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