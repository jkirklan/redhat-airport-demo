/* jshint devel:true */
var admin = (function($, window, document) {
  'use strict';

  var admin = {
    init: function() {
      this.resetButtonListener();

      this.flightOnTimeButtonListener();
      this.flightDelayedButtonListener();
      this.flightLateButtonListener();

      this.beaconOnTimeListener();
      this.beaconDelayedListener();
      this.beaconChangedListener();
      this.stopBeaconButtonListener();
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
          alert('On time flight on');
        }).fail(function(jqXHR, textStatus, error) {
          alert('On time flight failed');
          console.log(error);
        });
      });
    },
    flightDelayedButtonListener: function() {
      $('.flight-delayed-btn').on('click', function() {
        localStorage.setItem('delayedMode', 'true');
        alert('Delayed flight on');
      });
    },
    flightLateButtonListener: function() {
      $('.flight-late-btn').on('click', function() {
        $.ajax({
          url: 'http://redhatairportdemo-fguanlao.rhcloud.com/rest/flightStatus/70?demoMode=1',
          method: 'GET'
        }).done(function() {
          alert('Running late on');
        }).fail(function(jqXHR, textStatus, error) {
          alert('Running late failed');
          console.log(error);
        });
      });
    },
    beaconOnTimeListener: function() {
      $('.beacon-ontime-btn').on('click', function() {
        $.ajax({
          url: 'http://redhatairportdemo-fguanlao.rhcloud.com/rest/digitalSignage',
          data: { showDetails: 3 },
          method: 'POST'
        }).done(function() {
          alert('Beacon on time started');
        }).fail(function(jqXHR, textStatus, error) {
          alert('Beacon on time failed');
          console.log(error);
        });
      });
    },
    beaconDelayedListener: function() {
      $('.beacon-delayed-btn').on('click', function() {
        $.ajax({
          url: 'http://redhatairportdemo-fguanlao.rhcloud.com/rest/digitalSignage',
          data: { showDetails: 2 },
          method: 'POST'
        }).done(function() {
          alert('Beacon delayed started');
        }).fail(function(jqXHR, textStatus, error) {
          alert('Beacon delayed failed');
          console.log(error);
        });
      });
    },
    beaconChangedListener: function() {
      $('.beacon-changed-btn').on('click', function() {
        $.ajax({
          url: 'http://redhatairportdemo-fguanlao.rhcloud.com/rest/digitalSignage',
          data: { showDetails: 1 },
          method: 'POST'
        }).done(function() {
          alert('Beacon changed started');
        }).fail(function(jqXHR, textStatus, error) {
          alert('Beacon changed failed');
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