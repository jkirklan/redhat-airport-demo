/* jshint devel:true */
var admin = (function($, window, document) {
  'use strict';

  var admin = {
    init: function() {
      this.flightOnTimeButtonListener();
      this.flightDelayedButtonListener();
      this.flightLateButtonListener();
      this.technicalDetailsButtonListener();
    },
    resetButtonListener: function() {
      $('.reset-btn').on('click',function() {
        localStorage.clear();
        alert('Demo has been reset');
      });
    },
    flightOnTimeButtonListener: function() {
      $('.flight-ontime-btn').on('click', function() {
        $.ajax({
          url: 'http://redhatairportdemo-fguanlao.rhcloud.com/rest/flightStatus/70?demoMode=3',
          method: 'GET'
        }).done(function() {
          localStorage.setItem('demoMode', '3');
          alert('On time flight on');
        }).fail(function(jqXHR, textStatus, error) {
          alert('On time flight failed');
          console.log(error);
        });
      });
    },
    flightDelayedButtonListener: function() {
      $('.flight-delayed-btn').on('click', function() {
        $.ajax({
          url: 'http://redhatairportdemo-fguanlao.rhcloud.com/rest/flightStatus/70?demoMode=2',
          method: 'GET'
        }).done(function() {
          localStorage.setItem('delayedMode', 'true');
          localStorage.setItem('demoMode', '2');
          alert('Delayed flight on');
        }).fail(function(jqXHR, textStatus, error) {
          alert('Delayed flight failed');
          console.log(error);
        });
      });
    },
    flightLateButtonListener: function() {
      $('.flight-late-btn').on('click', function() {
        $.ajax({
          url: 'http://redhatairportdemo-fguanlao.rhcloud.com/rest/flightStatus/70?demoMode=1',
          method: 'GET'
        }).done(function() {
          localStorage.setItem('demoMode', '1');
          alert('Running late on');
        }).fail(function(jqXHR, textStatus, error) {
          alert('Running late failed');
          console.log(error);
        });
      });
    },
    technicalDetailsButtonListener: function() {
      $('.technical-details-btn').on('click', function() {
        $.ajax({
          url: 'http://redhatairportdemo-fguanlao.rhcloud.com/rest/digitalSignage/4',
          method: 'GET'
        }).done(function() {
          // localStorage.setItem('demoMode', '4');
          alert('Showing tech specs');
        }).fail(function(jqXHR, textStatus, error) {
          alert('Running late failed');
          console.log(error);
        });
      });
    },
    startBeaconButtonListener: function() {
      $('.beacon-start-btn').on('click', function() {
        $.ajax({
          url: 'http://redhatairportdemo-fguanlao.rhcloud.com/rest/digitalSignage',
          data: { showDetails: localStorage.getItem('demoMode') },
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
      $('.beacon-stop-btn').on('click', function() {
        $.ajax({
          url: 'http://redhatairportdemo-fguanlao.rhcloud.com/rest/digitalSignage',
          data: { showDetails: 0 },
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