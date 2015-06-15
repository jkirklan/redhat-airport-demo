/* jshint devel:true */
var home = (function($, window, document) {
  'use strict';

  var home = {
    init: function() {
      this.startDemo();
    },
    startDemo: function() {
      var that = this;

      var backupOnTimeData = {
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

      var backupDelayedData = {
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

      // Set ajax call to receive delayed status
      if (this.getQueryString('flight') === 'delayed') {
        this.getFlightData(4).done(function(data) {
          that.flightData = data;
          that.updateView();
        }).fail(function(jqXHR, textStatus, error) {
          that.flightData = backupDelayedData;
          that.updateView();
          console.log(error);
        });
      }
      else if (localStorage.getItem('delayed') === 'true') {
        this.flightData = JSON.parse(localStorage.getItem('flightData'));
        this.updateView();
      }
      // Normal view
      else {
        this.getFlightData(0).done(function(data) {
          that.flightData = data;
          that.updateView();
        }).fail(function(jqXHR, textStatus, error) {
          that.flightData = backupOnTimeData;
          that.updateView();
          console.log(error);
        });
      }

      that.createCouponStorage();

      // Demo modes
      if (localStorage.getItem('delayedMode') === 'true') {
        this.setDemoMode(2, 'delayedMode', 'delayed');
      }

    },
    setDemoMode: function(id, mode, status) {
      var that = this;

      // Show delayed flight data after timeout
      setTimeout(function() {
        that.getFlightData(id).done(function(data) {
          that.flightData = data;
          $('.current-flight').children().not('#current-flight-tmpl').remove();
          that.updateView();
          localStorage.setItem(mode, 'false');
          localStorage.setItem(status, 'true');
        }).fail(function(jqXHR, textStatus, error) {
          that.flightData = backupDelayedData;
          $('.current-flight').children().not('#current-flight-tmpl').remove();
          that.updateView();
          localStorage.setItem(mode, 'false');
          localStorage.setItem(status, 'true');
          console.log(error);
        });
      }, 5000);
    },
    updateView: function() {
      this.parseDepartureTime();
      this.compileHandlebarsTemplate();
      this.checkFlightStatus();
      localStorage.setItem('flightData', JSON.stringify(this.flightData));
    },
    getFlightData: function(demoMode) {
      var url = 'http://redhatairportdemo-fguanlao.rhcloud.com/rest/flightStatus/70?demoMode=' + demoMode;

      return $.ajax({
        url: url,
        method: 'GET'
      });
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
    },
    getQueryString: function(name) {
      name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
      var regex = new RegExp('[\\?&]' + name + '=([^&#]*)'),
          results = regex.exec(location.search);
      return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    }
  };

  return home;
}(jQuery, window, document));